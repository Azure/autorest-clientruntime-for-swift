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

public protocol ResponseInterceptor {
    func intercept(httpResponse: inout HTTPURLResponse, data: inout Data?) -> Void
}

public class CustomHeadersInterseptor : RequestInterceptor {
    
    let customHeaders:[String:String]
    
    init(customHeaders: [String:String]) {
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
    
    init(atc: AzureTokenCredentials) {
        self.atc = atc
    }
    
    public func intercept(url: inout String, method: inout String, headers: inout [String : String]?, body: inout Data?) {
        if headers == nil {
            headers = [:]
        }
        
        headers!["Authorization"] = try? atc.authHeaderValue(url: nil)
    }
}

public class LogInterceptor {
    
    fileprivate func prefix() -> String {
        return ""
    }
    
    fileprivate func printUrl(url: String) {
        if self.showOptions.contains(LogInterceptor.Show.all)
            || self.showOptions.contains(LogInterceptor.Show.url) {
            print(prefix(), url)
        }
    }
    
    fileprivate func printHeaders(headers:[String:String]?) {
        if self.showOptions.contains(LogInterceptor.Show.all)
            || self.showOptions.contains(LogInterceptor.Show.headers) {
            if let h = headers {
                for (key, value) in h {
                    if headersToHide.isEmpty || !headersToHide.contains(key.uppercased()) {
                        if headersToShow.isEmpty || headersToShow.contains(key.uppercased()) {
                            print(prefix(), "[\(key)] = \(value)")
                        }
                    }
                }
            }
        }
    }
    
    fileprivate func printBody(body: Data?) {
        if self.showOptions.contains(LogInterceptor.Show.all)
            || self.showOptions.contains(LogInterceptor.Show.body) {
            if let b = body {
                if let bodyAsString = String(data: b, encoding: .utf8) {
                    if (!bodyAsString.isEmpty) {
                        print(prefix(), bodyAsString)
                    }
                } else {
                    print(prefix(), "Can't get body")
                }
            }
        }
    }
    
    private var headersToShow = [String]()
    
    public func withHeadersToShow(_ headersToShow: [String]) -> Self {
        self.headersToShow = headersToShow.map{$0.uppercased()}
        return self
    }
    
    private var headersToHide = [String]()
    
    public func withHeadersToHide(_ headersToHide: [String]) -> Self {
        self.headersToHide = headersToHide.map{$0.uppercased()}
        return self
    }
    
    public enum Show {
        case url
        case headers
        case body
        case all
    }
    
    private var showOptions: Set<Show> = Set([.all])
    
    public init(showOptions: [Show]) {
        self.showOptions = Set(showOptions)
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
    
    fileprivate override func prefix() -> String {
        return "<--"
    }
    
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
    
    fileprivate override func prefix() -> String {
        return "-->\t"
    }
}

