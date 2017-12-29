/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 */

import Foundation
import RxSwift
import RxBlocking

public struct AuthResults: Codable {
    let ext_expires_in: String
    let token_type: String
    let not_before: String
    let access_token: String
    let resource: String
    let expires_on: String
    let expires_in: String
}

public enum ApplicationTokenCredentialsError: Error {
    case message(message: String)
    case cantParseResponceData
    case noResponse
    case cantConvertAuthResult
    case authResultIsNil
}

public class ApplicationTokenCredentials: AzureTokenCredentials {
    
    var tokens = Dictionary<String, AuthResults>()
    let clientId: String
    let clentSecret: String
    
    let disposeBag = DisposeBag()
    
    public init(clientId: String, clentSecret: String, environment: Environment, tenantId: String, subscriptionId: String?) {
        self.clientId = clientId
        self.clentSecret = clentSecret
        super.init(environment: environment, tenantId: tenantId, subscriptionId: subscriptionId)
        
//        let ar = AuthResults(ext_expires_in: "0", token_type: "Bearer", not_before: "1509742789", access_token: "NOOON", resource: "https://management.core.windows.net/", expires_on: "1509746689", expires_in: "3599")
//        tokens["https://login.windows.net/"] = ar
    }
    
    public static func fromFile(path: String) throws -> ApplicationTokenCredentials {
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
            throw ApplicationTokenCredentialsError.message(message: "Can't get token for resourse: \(forResource)")
        }
        
        return authResults.access_token
    }
    
    private func acquireTokenSync(forResource: String) throws -> AuthResults? {
        let obs : Single<AuthResults> = self.acquireToken(forResource: forResource)
        let obsBl = obs.toBlocking()
        return try obsBl.single()
    }
    
    private func acquireToken<T>(forResource: String) -> Single<T> where T:Decodable {
        let session = URLSession(configuration: .default)
        
        guard
            let baseUrl = self.environment.url(forEndpoint: .activeDirectory),
            let resourseUrl = self.environment.url(forEndpoint: .management) else {
            return Single.error(ApplicationTokenCredentialsError.message(message: ".activeDirectory or .resourseUrl endpoint is not set"))
        }
    
        let body = [
            "grant_type":  "client_credentials",
            "client_id": self.clientId,
            "client_secret": self.clentSecret,
            "resource": resourseUrl
        ]
        
        let bodyData = body.enumerated().map {
            (i, pair) -> String in
            let (key, value) = pair
            return i == 0
                ? "\(key)=\(value)"
                : "&\(key)=\(value)"
        }.map {
            $0.data(using: .utf8)!
        }.reduce(Data()) {
            $0 + $1
        }

        let url = baseUrl + self.tenantId + "/oauth2/token"
        
        let response = Observable.just(url).map { urlString -> URL in
            return URL(string: urlString)!
        }.map { url -> URLRequest in
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = bodyData
            return request
        }.flatMap { request -> Observable<(HTTPURLResponse, Data)> in
            return Single<(HTTPURLResponse, Data)>.create { single in
                let task = session.dataTask(with: request, completionHandler: { data, response, error in
                    if let executionError = error {
                        single(.error(executionError))
                        return
                    }
                    guard let cmdResponse = response as? HTTPURLResponse else {
                        single(.error(RuntimeError.general(message: "=== Failed to downcast URLResponse to HTTPURLResponse")))
                        return
                    }
                    guard let cmdData = data else {
                        single(.error(RuntimeError.general(message: "=== Response data is nil")))
                        return
                    }
                   
                    single(.success((cmdResponse, cmdData)))
                })
                
                task.resume()
                
                return Disposables.create {
                    task.cancel()
                }
            }.asObservable()
        }.flatMap { (httpResponse: HTTPURLResponse, data: Data) -> Observable<T> in
            do {
//                if let bodyAsString = String(data: data, encoding: .utf8) {
//                    if (!bodyAsString.isEmpty) {
//                        print("=== Data from string:",bodyAsString)
//                    }
//                }
                let authResult = try JSONDecoder().decode(T.self, from: data)
                return Observable.just(authResult)
            } catch {
                return Observable.error(error)
            }
        }
        
        return response.asSingle()
    }
}


