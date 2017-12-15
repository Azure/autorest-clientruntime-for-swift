//
//  ResponseInterceptor.swift
//  azureSwiftRuntimeTests
//
//  Created by Vladimir Shcherbakov on 12/12/17.
//

import Foundation

public protocol ResponseInterceptor {
    func intercept(httpResponse: inout HTTPURLResponse, data: inout Data?) -> Void
}

public class LogResponseInterceptor : LogInterceptor, ResponseInterceptor {
    override public init(showOptions: Show...) {
        super.init(showOptions: showOptions)
    }
    
    public func intercept(httpResponse: inout HTTPURLResponse, data: inout Data?) {
        let url = httpResponse.url?.absoluteString ?? "Url is nil"
        //let url = ""
        printUrl(url: "\(httpResponse.statusCode) \(url)")
        printHeaders(headers: httpResponse.allHeaderFields as? [String:String])
        printBody(body: data)
    }
    
    override func prefix() -> String {
        return "-->\t"
    }
}
