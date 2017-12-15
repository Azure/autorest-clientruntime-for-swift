//
//  LogInterceptor.swift
//  azureSwiftRuntimeTests
//
//  Created by Vladimir Shcherbakov on 12/12/17.
//

import Foundation

public class LogInterceptor {
    
    func prefix() -> String {
        return ""
    }
    
    func printUrl(url: String) {
        if self.showOptions.contains(LogInterceptor.Show.all)
            || self.showOptions.contains(LogInterceptor.Show.url) {
            print(prefix(), url)
        }
    }
    
    func printHeaders(headers:[String:String]?) {
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
    
    func printBody(body: Data?) {
        if self.showOptions.contains(LogInterceptor.Show.all)
            || self.showOptions.contains(LogInterceptor.Show.body) {
            if let b = body {
                if b.count > 0 && b.count < 1024 {
                    if let bodyAsString = String(data: b, encoding: .utf8) {
                        if (!bodyAsString.isEmpty) {
                            print(prefix(), bodyAsString)
                        }
                    }
                } else {
                    print(prefix(), b)
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
