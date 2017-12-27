//
//  AzureClient-Interception.swift
//  azureSwiftRuntime
//
//  Created by Vladimir Shcherbakov on 12/13/17.
//

import Foundation
import RxSwift

public extension AzureClient {
    
    public func withRequestInterceptor(_ requestInterceptor: RequestInterceptor) -> AzureClient {
        self.requestInterceptors.append(requestInterceptor)
        return self
    }
    
    public func withResponseInterceptor(_ responseInterceptor: ResponseInterceptor) -> AzureClient {
        self.responseInterceptors.append(responseInterceptor)
        return self
    }
    
    internal func executeRequestWithInterception (url: String, method: String = "GET", headers:[String:String]? = nil, body: Data? = nil) -> Observable<ResponseData> {
        return self.executeRequest(url: url, method: method, headers: headers, body: body)
            .asObservable()
            .map {
                httpResponse, data -> ResponseData in
                var _httpResponse = httpResponse
                var _data = data
                
                for interceptor in self.responseInterceptors {
                    interceptor.intercept(httpResponse: &_httpResponse, data: &_data)
                }
                
                try self.handleErrorCode(statusCode: httpResponse.statusCode, data: data)
                return (_httpResponse, _data)
            }.retryWhen { (e: Observable<Error>) -> Observable<Int> in
                return e.flatMapWithIndex { (e, i) -> Observable<Int> in
                    switch(e) {
                    case RuntimeError.errorStatusCode(let code, _):
                        if code >= 500  && i < 2 {
                            return Observable<Int>.just(i+1)
                                .delay(RxTimeInterval(self.retryDelay), scheduler: ConcurrentDispatchQueueScheduler(queue: self.queueWorker))
                        } else {
                            return Observable.error(e)
                        }
                    default:
                        return Observable.error(e)
                    }
                }
            }
    }
}
