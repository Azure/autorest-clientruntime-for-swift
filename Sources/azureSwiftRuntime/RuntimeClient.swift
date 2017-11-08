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

protocol RuntimeClient {
//    func execute<Command,RetType>(command: Command) -> RetType where RetType: Decodable, Command: BareCommand
    //associatedtype RetType where RetType: Decodable
    func execute(command: BaseCommand) throws -> Decodable?
    //func execute<RetType>(command: BaseCommand) -> RetType
    //func buildUrl(command: BaseCommand, baseUrl: String) -> String
}

class MyDecoder: ResponseDecoder {
    func decode<T>(_ type: T.Type, from jsonString: String) throws -> T where T : Decodable {
        guard let jsonData = jsonString.data(using: .utf8) else {
            throw RuntimeClientError.executionError(message: "Can't get data form string utf8")
        }
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: jsonData)
    }
}

class AzureClient: RuntimeClient {
    
    let atc : AzureTokenCredentials
    let oauth2Handler: OAuth2Handler
    let sessionManager = SessionManager()
    
    init(atc: AzureTokenCredentials) {
        self.atc = atc
        self.oauth2Handler = OAuth2Handler(azureTokenCredentials: self.atc)
        sessionManager.adapter = oauth2Handler
    }
    
    func execute(command: BaseCommand) throws -> Decodable? {
        
        let url = self.buildUrl(command: command, baseUrl: self.atc.environment.url(forEndpoint: .resourceManager))

        guard let method = HTTPMethod(rawValue: command.method.uppercased()) else {
            throw RuntimeClientError.executionError(message: "Can't parse command method to HTTPMethod enum")
        }
        guard let retString = try self.executeRequest(url: url, method: method, parameters: Parameters(), headers: command.headerParameters).toBlocking().single() else {
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
            
            let request = self.sessionManager.request(url, method: method, parameters: parameters, headers: headers)
                .responseString(completionHandler: {
                    response in
                    
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
            
            return Disposables.create{
                request.cancel()
            }
        }
    }
    
    
}

//{"error":{"code":"MissingApiVersionParameter","message":"The api-version query parameter (?api-version=) is required for all requests."}}

class ReturnError: Codable {
    let error: ReturnErrorData
}
class ReturnErrorData: Codable {
    let code: String
    let message: String
}

enum RuntimeClientError: Error {
    case executionError(message: String)
    
}
