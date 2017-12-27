//
//  RuntimeClient-LRO.swift
//  azureSwiftRuntime
//
//  Created by Vladimir Shcherbakov on 12/13/17.
//

import Foundation
import RxSwift

public extension AzureClient {
    
    // handles long-running operations with retry loginc
    public func executeAsyncLRO(command: BaseCommand, completionHandler: @escaping (Decodable?, Error?)->Void){
        
        let firstRequestObservable = Observable.just(command)
            .map { c -> RequestParams in
                return try self.prepareRequest(command: c)
            }.flatMap { (requestParams: RequestParams) -> Observable<ResponseData> in
                let (url, method, headers, body) = requestParams
                return self.executeRequestWithInterception (url: url, method: method, headers: headers, body: body).asObservable()
            }

        let responseParserObservable = firstRequestObservable
            .map { httpResponse, data -> ResponseData in
                let statusCode = httpResponse.statusCode
                try self.handleErrorCode(statusCode: statusCode, data: data)
                return (httpResponse, data)
            }.flatMap { httpResponse, data -> Observable<ResponseData> in
                guard let url = httpResponse.url?.absoluteString else {
                    return Observable.error(RuntimeError.general(message: "Can't get url form response"))
                }
                let method = command.method
                
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
            //.subscribeOn(ConcurrentDispatchQueueScheduler(queue: queueWorker))
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
    }
    
    internal enum RetryConditionError: Error {
        case needRetry
    }
    
    internal struct Status : Codable {
        let status: String
        
        enum Value: String {
            case Accepted = "Accepted"
            case InProgress = "InProgress"
            case Succeeded = "Succeeded"
            case Failed = "Failed"
            case Canceled = "Canceled"
        }
    }
    
    internal struct ProvisionState: Codable {
        let provisioningState: String
        enum Value: String {
            case Accepted = "Accepted"
            case Creating = "Creating"
            case Failed = "Failed"
            case Canceled = "Canceled"
            case Succeeded = "Succeeded"
        }
    }
    
    internal struct ProvisionStateProp : Codable {
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
                
                if let result = try? CoderFactory.decoder(for: .json).decode(Status.self, from: body) {
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
                    if let result = try? CoderFactory.decoder(for: .json).decode(ProvisionStateProp.self, from: body) {
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
                    if JSONSerialization.isValidJSONObject(body) {
                        throw RuntimeError.general(message: "Can't parse the body")
                    } else {
                        throw RuntimeError.invalidData
                    }
                }
                
            } else {
                throw RuntimeError.general(message: "No data in the body")
            }
            
        default:
            return true
        }
        
        return false
    }
}
