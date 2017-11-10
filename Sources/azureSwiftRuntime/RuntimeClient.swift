//
//  RuntimeClient.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Vladimir Shcherbakov on 11/7/17.
//

import Foundation
import Alamofire
import RxSwift
import RxBlocking

public protocol RuntimeClient {
    func execute(command: BaseCommand) throws -> Decodable?
}

public class MyDecoder: ResponseDecoder {
    public func decode<T>(_ type: T.Type, from jsonString: String) throws -> T where T : Decodable {
        guard let jsonData = jsonString.data(using: .utf8) else {
            throw RuntimeClientError.executionError(message: "Can't get data form string utf8")
        }
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: jsonData)
    }
}

public class AzureClient: RuntimeClient {
    let atc : AzureTokenCredentials
    let oauth2Handler: OAuth2Handler
    let sessionManager = SessionManager()
    
    public init(atc: AzureTokenCredentials) {
        self.atc = atc
        self.oauth2Handler = OAuth2Handler(azureTokenCredentials: self.atc)
        sessionManager.adapter = oauth2Handler
    }
    
    public func execute(command: BaseCommand) throws -> Decodable? {
        
        command.preCall()
        
        let url = self.buildUrl(command: command, baseUrl: self.atc.environment.url(forEndpoint: .resourceManager))
        
        guard let method = HTTPMethod(rawValue: command.method.uppercased()) else {
            throw RuntimeClientError.executionError(message: "Can't parse command method to HTTPMethod enum")
        }
        
        var params = Parameters()
        if command.body != nil {
            guard let jsonData = try command.encodeBody() else {
                throw RuntimeClientError.executionError(message: "body json is nil")
            }
            
            guard let bodyAsDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                throw RuntimeClientError.executionError(message: "Can't cast body json to dictionary")
            }
            params = bodyAsDict
        }
        
        guard let retString = try self.executeRequest(url: url, method: method, parameters: params, headers: command.headerParameters).toBlocking().single() else {
            return nil
        }
        
        if retString.isEmpty {
            return nil
        }
        
        let decoder = MyDecoder()
        return try command.returnFunc(decoder: decoder, jsonString: retString)
    }
    
    func buildUrl(command: BaseCommand, baseUrl: String) -> String {
        var fullUrl = baseUrl + command.path
        for (key, value) in command.pathParameters {
            //replace parameter in full url with path parameter value
            fullUrl = fullUrl.replacingOccurrences(of: key, with: value)
        }
        
        if !command.queryParameters.isEmpty {
            var queryString = ""
            var veryFirstParam = true
            for (key, value) in command.queryParameters {
                //add query parameter to full url with path parameter value
                queryString += veryFirstParam
                    ? "?\(key)=\(value)"
                    : "&\(key)=\(value)"
                veryFirstParam = false
            }
            fullUrl += queryString
        }
        
        return fullUrl;
    }
    private func executeRequest(url: String, method: HTTPMethod, parameters: Parameters, headers: HTTPHeaders) -> Single<String>{
        return Single<String>.create{ single in
            
            let request = (parameters.isEmpty)
                ? self.sessionManager.request(url, method: method, headers: headers)
                : self.sessionManager.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            
            request.responseString(completionHandler: {
                response in
                
                
                if let error = response.error {
                    single(.error(error))
                    return
                }
                
                guard let response1 = response.response else {
                    single(.error(RuntimeClientError.executionError(message: "Response is nil")))
                    return
                }
                
                let statusCode = response1.statusCode
                
                guard let responseString = response.result.value,
                    let jsonData = responseString.data(using: .utf8) else {
                        single(.error(RuntimeClientError.executionError(message: "Response string is nil")))
                        return
                }
                
                if statusCode >= 400 {
                    let decoder = JSONDecoder()
                    guard let returnedJson = try? decoder.decode(ReturnError.self, from: jsonData) else {
                        single(.error(RuntimeClientError.executionError(message: responseString)))
                        return
                    }
                    single(.error(RuntimeClientError.executionError(message: returnedJson.error.code + ": " + returnedJson.error.message)))
                    return
                }
                
                single(.success(responseString))
            })
            
            print(request)
            
            return Disposables.create{
                request.cancel()
            }
        }
    }
}

//{"error":{"code":"MissingApiVersionParameter","message":"The api-version query parameter (?api-version=) is required for all requests."}}

public class ReturnError: Codable {
    let error: ReturnErrorData
}
public class ReturnErrorData: Codable {
    let code: String
    let message: String
}

public enum RuntimeClientError: Error {
    case executionError(message: String)
    
}

