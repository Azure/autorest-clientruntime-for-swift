//
//  AzureClient.swift
//  azureSwiftRuntimeTests
//
//  Created by Vladimir Shcherbakov on 12/13/17.
//

import Foundation
import RxSwift
import RxBlocking

public class AzureClient: RuntimeClient {
    
    public func executeAsync<T>(command: BaseCommand) throws -> Observable<T?> {
        let (url, method, headers, body) = try self.prepareRequest(command: command)
        return self.executeRequestWithInterception (url: url, method: method, headers: headers, body: body)
            .asObservable()
            .flatMap{ httpResponse, data -> Observable<T?> in
                try self.handleErrorCode(statusCode: httpResponse.statusCode, data: data)
                if let body = data {
                    let decodable = try? command.returnFunc(data: body)
                    return Observable<T?>.just(decodable as! T?)
                } else {
                    return Observable<T?>.just(nil)
                }
            }.subscribeOn(ConcurrentDispatchQueueScheduler(queue: self.queueWorker))
    }
        
    // handles non-long-running operations (blocking)
    public func execute (command: BaseCommand) throws -> Decodable? {
        
        let (url, method, headers, body) = try self.prepareRequest(command: command)
        
        guard let (httpResponse, data) = try self.executeRequestWithInterception(url: url, method: method, headers: headers, body: body)
            .toBlocking()
            .single() else {
                
            throw RuntimeError.general(message: "Request returned nil")
        }
        
        try self.handleErrorCode(statusCode: httpResponse.statusCode, data: data)
        
        do {
            let decodable = try command.returnFunc(data: data!)
            return decodable
        } catch DecodeError.nilData { // to return nil not empty string or data
            return nil
        }
    }
    
    // handles non-long-running operations
    public func executeAsync (command: BaseCommand, completionHandler: @escaping (Decodable?, Error?) -> Void) throws {
        
        let (url, method, headers, body) = try self.prepareRequest(command: command)
        
        self.executeRequestWithInterception (url: url, method: method, headers: headers, body: body)
            .asObservable()
            .subscribe(
                onNext:{ (httpResponse, data) in
                    if let body = data {
                        let decodable = try? command.returnFunc(data: body)
                        completionHandler(decodable, nil)
                    } else {
                        completionHandler(nil, nil)
                    }
                },
                onError: { error in
                    completionHandler(nil,error)
                }
            ).disposed(by: disposeBag)
    }
    
    internal var retryDelay = 0.01
    
    public func withRetryDelay(_ retryDelay: TimeInterval) {
        self.retryDelay = retryDelay
    }
    
    internal var requestInterceptors: [RequestInterceptor] = []
    internal var responseInterceptors: [ResponseInterceptor] = []
    
    let atc : AzureTokenCredentials
    
    var disposeBag = DisposeBag()
    
    public init(atc: AzureTokenCredentials) {
        self.atc = atc
        if let _ = atc.environment.url(forEndpoint: .activeDirectory) {
            _ = self.withRequestInterceptor(AuthHeaderInterseptor(atc: atc))
        }
    }
    
    internal func buildUrl (command: BaseCommand, baseUrl: String) -> String {
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
    
    internal typealias RequestParams = (url: String, method: String, headers: [String:String]?, body: Data?)
    
    internal func prepareRequest (command: BaseCommand) throws -> RequestParams  {
        command.preCall()
        
        guard let baseUrl = self.atc.environment.url(forEndpoint: .resourceManager) else {
            throw RuntimeError.general(message: "Base URL is not set")
        }
        
        let url = self.buildUrl(command: command, baseUrl: baseUrl)
        
        var bodyData: Data? = nil
        if command.body != nil {
            guard let jsonData = try command.encodeBody() else {
                throw RuntimeError.general(message: "Failed to encode body")
            }
            
            bodyData = jsonData
        }
        
        return (url, command.method.uppercased() , command.headerParameters, bodyData)
    }
    
    let queueWorker = DispatchQueue(label: "com.microsoft.executeAsync", qos: .userInitiated)
    
    internal typealias ResponseData = (HTTPURLResponse, Data?)
    internal let session = URLSession(configuration: .default)
    
    deinit {
        session.finishTasksAndInvalidate()
    }
    
    internal func executeRequest (url: String, method: String = "GET", headers:[String:String]? = nil, body: Data? = nil) -> Single<ResponseData> {
        return Single<ResponseData>.create { single in
            var _urlStr = url, _method = method, _headers = headers, _body = body
            
            for interceptor in self.requestInterceptors {
                interceptor.intercept(url: &_urlStr, method: &_method, headers: &_headers, body: &_body)
            }
            
            guard let url = URL(string: _urlStr) else {
                single(.error(RuntimeError.general(message: "=== Can not create URL")))
                return Disposables.create()
            }
            
            var cmdRequest = URLRequest(url: url)
            cmdRequest.httpMethod = _method
            cmdRequest.allHTTPHeaderFields = _headers
            cmdRequest.httpBody = _body
            
            let task = self.session.dataTask(with: cmdRequest, completionHandler: {
                data, response, error in
                
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
                
                let responsePair: ResponseData = (cmdResponse, cmdData)
                single(.success(responsePair))
                
            })
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

