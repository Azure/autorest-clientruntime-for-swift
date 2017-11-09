//
//  ApplicationTokenCredentials.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Vladimir Shcherbakov on 10/31/17.
//

import Foundation
import RxSwift
import Alamofire
import RxBlocking

struct AuthResults: Codable {
    let ext_expires_in: String
    let token_type: String
    let not_before: String
    let access_token: String
    let resource: String
    let expires_on: String
    let expires_in: String
}

enum ApplicationTokenCredentialsError: Error {
    case cantGetToken
    case cantParseResponceData
    case noResponse
    case cantConvertAuthResult
    case authResultIsNil
}

class ApplicationTokenCredentials: AzureTokenCredentials {
    
    var tokens = Dictionary<String, AuthResults>()
    let clientId: String
    let clentSecret: String
    
    init(clientId: String, clentSecret: String, environment: Environment, tenantId: String, subscriptionId: String?) {
        self.clientId = clientId
        self.clentSecret = clentSecret
        super.init(environment: environment, tenantId: tenantId, subscriptionId: subscriptionId)
        
//        let ar = AuthResults(ext_expires_in: "0", token_type: "Bearer", not_before: "1509742789", access_token: "NOOON", resource: "https://management.core.windows.net/", expires_on: "1509746689", expires_in: "3599")
//        tokens["https://login.windows.net/"] = ar
    }
    
    static func fromFile(path: String) throws -> ApplicationTokenCredentials {
        let fileData = try AuthFile.parseJsonFile(path: path)
        let env = AuzureEnvironment(endpoints:[
            .management         : fileData.managementURI,
            .activeDirectory    : fileData.authURL,
            .resourceManager    : fileData.baseURL
        ])
        return ApplicationTokenCredentials(clientId: fileData.client, clentSecret: fileData.key, environment: env, tenantId: fileData.tenant, subscriptionId: fileData.subscription)
    }

    override func getToken(forResource: String) throws -> String {
        if let authResults = self.tokens[forResource] {
            if let exp = TimeInterval(authResults.expires_on)  {
                let tokenExpirationDate = Date.init(timeIntervalSince1970: exp)
                let secsLeft = tokenExpirationDate.timeIntervalSince(Date())
                let secsInMin = 3600
                // if token has expired or will expire in less than 10 minutes
                if secsLeft < 0 || Int(secsLeft) / secsInMin < 10 {
                    guard let authResults = try self.acquireTokenSync(forResource: forResource) else {
                        throw ApplicationTokenCredentialsError.authResultIsNil
                    }
                    self.tokens[forResource] = authResults
                }
            } else {
                throw ApplicationTokenCredentialsError.cantConvertAuthResult
            }
        } else {
            guard let authResults = try self.acquireTokenSync(forResource: forResource) else {
                throw ApplicationTokenCredentialsError.authResultIsNil
            }
            self.tokens[forResource] = authResults
        }
        
        guard let authResults = self.tokens[forResource] else {
            throw ApplicationTokenCredentialsError.cantGetToken
        }
        
        return authResults.access_token
    }
    
    private func acquireTokenSync(forResource: String) throws -> AuthResults? {
        let obs : Single<AuthResults> = self.acquireToken(forResource: forResource)
        let obsBl = obs.toBlocking()
        return try obsBl.single()
    }
    
    private func acquireToken<T>(forResource: String) -> Single<T> where T:Decodable {
        return Single<T>.create{ single in
            let uri = self.environment.url(forEndpoint: .activeDirectory) + self.tenantId + "/oauth2/token"
            let parameters: Parameters = [
                "grant_type":  "client_credentials",
                "client_id": self.clientId,
                "client_secret": self.clentSecret,
                "resource": self.environment.url(forEndpoint: .management)
            ]
            
            let request = Alamofire.request(uri, method: .post, parameters: parameters)
                .responseString(completionHandler: {
                    response in
                    if response.result.isSuccess {
                        if let jsonString = response.result.value,
                           let jsonData = jsonString.data(using: .utf8) {
                            do {
                                let authResult = try JSONDecoder().decode(T.self, from: jsonData)
                                single(.success(authResult))
                            } catch {
                                print("=== Error: \(error)")
                                single(.error(error))
                            }
                        } else {
                            single(.error(ApplicationTokenCredentialsError.cantParseResponceData))
                        }
                    } else {
                        single(.error(ApplicationTokenCredentialsError.noResponse))
                    }
                })
            
            return Disposables.create{
                request.cancel()
            }
        }
    }
}

