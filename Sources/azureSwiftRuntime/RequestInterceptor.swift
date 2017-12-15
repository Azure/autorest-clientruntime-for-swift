//
//  Interceptor.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Vladimir Shcherbakov on 11/29/17.
//

import Foundation

public protocol RequestInterceptor {
    func intercept(url: inout String, method: inout String, headers: inout [String:String]?, body: inout Data?) -> Void
}

public class CustomHeadersInterseptor : RequestInterceptor {
    
    let customHeaders:[String:String]
    
    public init(customHeaders: [String:String]) {
        self.customHeaders = customHeaders
    }
    
    public func intercept(url: inout String, method: inout String, headers: inout [String : String]?, body: inout Data?) {
        
        if headers == nil {
            headers = [:]
        }
        for (key, value) in self.customHeaders {
            headers![key] = value
        }
    }
}

public class AuthHeaderInterseptor : RequestInterceptor {
    
    let atc: AzureTokenCredentials
    
    public init(atc: AzureTokenCredentials) {
        self.atc = atc
    }
    
    public func intercept(url: inout String, method: inout String, headers: inout [String : String]?, body: inout Data?) {
        if headers == nil {
            headers = [:]
        }
        
        headers!["Authorization"] = try? atc.authHeaderValue(url: nil)
    }
}

public class LogRequestInterceptor : LogInterceptor, RequestInterceptor {
    override public init(showOptions: Show...) {
        super.init(showOptions: showOptions)
    }
    
    public func intercept(url: inout String, method: inout String, headers: inout [String : String]?, body: inout Data?) {
        printUrl(url: "\(method) \(url)")
        printHeaders(headers: headers)
        printBody(body: body)
    }
    
    override func prefix() -> String {
        return "<--"
    }
    
}

