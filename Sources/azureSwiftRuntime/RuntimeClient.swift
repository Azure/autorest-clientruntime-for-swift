//
//  RuntimeClient.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Vladimir Shcherbakov on 11/7/17.
//

import Foundation
import RxSwift
import RxBlocking

public protocol RuntimeClient {
    func execute(command: BaseCommand) throws -> Decodable?
    func executeAsync(command: BaseCommand, completionHandler: @escaping (Decodable?, Error?)->Void) throws
    func executeAsyncLRO(command: BaseCommand, completionHandler: @escaping (Decodable?, Error?)->Void) throws
}

public class AzureClient: RuntimeClient {
    
    private var requestInterceptors: [RequestInterceptor] = []
    
    public func withRequestInterceptor(_ requestInterceptor: RequestInterceptor) -> AzureClient {
        self.requestInterceptors.append(requestInterceptor)
        return self
    }
    
    private var responseInterceptors: [ResponseInterceptor] = []
    
    public func withResponseInterceptor(_ responseInterceptor: ResponseInterceptor) -> AzureClient {
        self.responseInterceptors.append(responseInterceptor)
        return self
    }
    
    var retryDelay = 0.01
    
    public func withRetryDelay(_ retryDelay: TimeInterval) {
        self.retryDelay = retryDelay
    }
    
    let atc : AzureTokenCredentials
    
    var disposeBag = DisposeBag()
    
    let decoder = JsonResponseDecoder()
    
    public init(atc: AzureTokenCredentials) {
        self.atc = atc
        if let _ = atc.environment.url(forEndpoint: .activeDirectory) {
            _ = self.withRequestInterceptor(AuthHeaderInterseptor(atc: atc))
        }
    }
    
    func buildUrl (command: BaseCommand, baseUrl: String) -> String {
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
    
    typealias RequestParams = (url: String, method: String, headers: [String:String]?, body: Data?)
    
    func prepareRequest (command: BaseCommand) throws -> RequestParams  {
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
    //let queueDelay = DispatchQueue(label: "com.microsoft.delay", qos: .userInitiated)
  
    typealias ResponseData = (HTTPURLResponse, Data?)
    let session = URLSession(configuration: .default)
    
    deinit {
        session.finishTasksAndInvalidate()
    }
    
    func executeRequest (url: String, method: String = "GET", headers:[String:String]? = nil, body: Data? = nil) -> Single<ResponseData> {
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
    
    func executeRequestWithInterception (url: String, method: String = "GET", headers:[String:String]? = nil, body: Data? = nil) -> Observable<ResponseData> {
        return self.executeRequest(url: url, method: method, headers: headers, body: body)
            .asObservable().flatMap {
                httpResponse, data -> Observable<ResponseData> in
                var _httpResponse = httpResponse
                var _data = data

                for interceptor in self.responseInterceptors {
                    interceptor.intercept(httpResponse: &_httpResponse, data: &_data)
                }

                return Observable<ResponseData>.just((_httpResponse, _data))
            }
    }
    
    // handles non-long-running operations (blocking)
    public func execute (command: BaseCommand) throws -> Decodable? {
        let (url, method, headers, body) = try self.prepareRequest(command: command)
        guard let (httpResponse, data) = try self.executeRequestWithInterception(url: url, method: method, headers: headers, body: body).toBlocking().single() else {
            throw RuntimeError.general(message: "executeRequestAsync returned nil")
        }
        
        try self.handleErrorCode(statusCode: httpResponse.statusCode, data: data)
        do {
            let decodable = try command.returnFunc(data: data!)
            return decodable
        } catch DecodeError.nilString {
            return nil
        }
    }
    
    // handles non-long-running operations
    public func executeAsync (command: BaseCommand, completionHandler: @escaping (Decodable?, Error?)->Void) throws {
        let (url, method, headers, body) = try self.prepareRequest(command: command)
        self.executeRequestWithInterception(url: url, method: method, headers: headers, body: body)
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
    
    enum RetryConditionError: Error {
        case needRetry
    }

    // handles long-running operations with retry loginc
    public func executeAsyncLRO (command: BaseCommand, completionHandler: @escaping (Decodable?, Error?)->Void) throws {
        do {
            let (url, method, headers, body) = try self.prepareRequest(command: command)
            let firstRequestObservable = self.executeRequestWithInterception(url: url, method: method, headers: headers, body: body).asObservable()
            let responseParserObservable = firstRequestObservable
                .flatMap { httpResponse, data -> Observable<ResponseData> in
                    let statusCode = httpResponse.statusCode
                    do {
                        try self.handleErrorCode(statusCode: statusCode, data: data)
                    } catch {
                        return Observable.error(error)
                    }
                    
                    let headers = httpResponse.allHeaderFields
                    var statusUrl = String()
                    var isAsyncOperation = false
                    if let asyncOperation = headers["Azure-AsyncOperation"] as? String {
                        statusUrl = asyncOperation
                        isAsyncOperation = true
                    } else if let location = headers["Location"] as? String {
                        statusUrl = location
                    }
                    
                    // check completion status
                    if statusUrl.isEmpty
                        || (isAsyncOperation && method.uppercased() != "DELETE") {
                        do {
                            if try self.checkCompletionStatus(command: command, responseData: (httpResponse, data)) {
                                return Observable<ResponseData>.just((httpResponse, data))
                            }
                            
                        } catch {
                            return Observable.error(error)
                        }
                    }
                    
                    if statusUrl.isEmpty  {
                        statusUrl = url
                    }
                    
                    return self.executeRequestWithInterception(url: statusUrl).asObservable()
                        .flatMap { httpResponse, data -> Observable<ResponseData> in
                            let headers = httpResponse.allHeaderFields
                            var statusUrl = String()
                            if let asyncOperation = headers["Azure-AsyncOperation"] as? String {
                                statusUrl = asyncOperation
                            } else if let location = headers["Location"] as? String {
                                statusUrl = location
                            }
                            
                            if !statusUrl.isEmpty {
                                return self.executeRequestWithInterception(url: statusUrl).asObservable()
                            }
                            
                            return Observable<ResponseData>.just((httpResponse, data))
                        }.map { (httpResponse, data) -> ResponseData in
                            let done = try self.checkCompletionStatus(command: command, responseData: (httpResponse, data))
                            if !done {
                                throw RetryConditionError.needRetry
                            }
                            
                            return (httpResponse, data)
                        }.retryWhen { (e: Observable<Error>) -> Observable<Int> in
                            return e.flatMapWithIndex { (e, i) -> Observable<Int> in
                                switch(e) {
                                case RetryConditionError.needRetry:
                                    print("===", "Delay")
                                    return Observable<Int>.just(i+1)
                                        .delay(RxTimeInterval(self.retryDelay), scheduler: ConcurrentDispatchQueueScheduler(queue: self.queueWorker))
                                default:
                                    return Observable.error(e)
                                }
                            }
                            
                        }.flatMap { httpResponse, data -> Observable<ResponseData> in
                            if (isAsyncOperation && method.uppercased() != "DELETE" && method.uppercased() != "POST") {
                                return self.executeRequestWithInterception(url: url, method: "GET").asObservable()
                            }
                            
                            return Observable<ResponseData>.just((httpResponse, data))
                        }
            }
            
            responseParserObservable
                .subscribeOn(ConcurrentDispatchQueueScheduler(queue: queueWorker))
                .subscribe(
                    onNext: { (httpResponse, data) in
                        if let body = data {
                            let decodable = try? command.returnFunc(data: body)
                            completionHandler(decodable, nil)
                        } else {
                            completionHandler(nil,nil)
                        }
                    },
                    onError: { e in
                        completionHandler(nil,e)
                    }
                ).disposed(by: disposeBag)
        } catch {
            completionHandler(nil,error)
        }
    }
 
    // === Private helpers
    
    struct Status : Codable {
        let status: String
        
        enum Value: String {
            case Accepted = "Accepted"
            case InProgress = "InProgress"
            case Succeeded = "Succeeded"
            case Failed = "Failed"
            case Canceled = "Canceled"
        }
    }
    
    struct ProvisionState: Codable {
        let provisioningState: String
        enum Value: String {
            case Accepted = "Accepted"
            case Creating = "Creating"
            case Failed = "Failed"
            case Canceled = "Canceled"
            case Succeeded = "Succeeded"
        }
    }
    
    struct ProvisionStateProp : Codable {
        let properties : ProvisionState
    }
    
    private func checkCompletionStatus(command: BaseCommand, responseData: ResponseData) throws -> Bool {
        let (httpResponse, data) = responseData
   
        try self.handleErrorCode(statusCode: httpResponse.statusCode, data: data)

        switch httpResponse.statusCode {
        case 200, 201, 202:
            if let body = data {
                
                if body.isEmpty {
                    if httpResponse.statusCode == 200 {
                        return true
                    }
                    
                    return false
                }                
                
                if let result = try? JsonResponseDecoder.decode(Status.self, from: body) {
                    if let status = Status.Value(rawValue: result.status) {
                        switch status {
                        case .Accepted, .InProgress:
                            return false
                        case .Succeeded:
                            return true
                        case .Failed:
                            throw RuntimeError.operationFailed
                        case .Canceled:
                            throw RuntimeError.operationCanceled
                        }
                    } else {
                        throw RuntimeError.general(message: "Unexpected status")
                    }
                    
                } else if try command.returnFunc(data: body) != nil {
                    if let result = try? JsonResponseDecoder.decode(ProvisionStateProp.self, from: body) {
                        //print("Result:", result)
                        if let provisioningState: ProvisionState.Value = ProvisionState.Value(rawValue: result.properties.provisioningState) {
                            switch provisioningState {
                            case .Succeeded:
                                return true
                            case .Creating, .Accepted:
                                return false
                            case .Canceled:
                                throw RuntimeError.operationCanceled
                            case .Failed:
                                throw RuntimeError.operationFailed
                            }
                        }
                    } else {
                        return true
                    }
                } else {
                    throw RuntimeError.general(message: "Can't parse the body")
                }
                
            } else {
                throw RuntimeError.general(message: "No data in the body")
            }
            
        default:
            return true
        }
        
        return false
    }
    
    private func handleErrorCode(statusCode: Int, data: Data?) throws {
        if statusCode >= 400 {
            if let jsonData = data {
                if jsonData.count == 0 {
                    throw RuntimeError.errorStatusCode(code: statusCode, details: "no details")
                } 

                if let cloudError = try? JsonResponseDecoder.decode(CloudError.self, from: jsonData) {
                    throw RuntimeError.cloud(error: cloudError)
                } else {
                    let str = String(data: jsonData, encoding: .utf8)
                    throw RuntimeError.errorStatusCode(code: statusCode, details: str ?? "can't get details")
                }
            }
        }
    }
}
