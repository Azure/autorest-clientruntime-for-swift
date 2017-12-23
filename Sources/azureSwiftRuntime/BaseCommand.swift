//
//  BaseCommand.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Vladimir Shcherbakov on 11/7/17.
//

import Foundation

open class BaseCommand {
    public var method: String
    public var isLongRunningOperation: Bool
    public var path: String
    public var pathParameters = [String: String]()
    public var queryParameters = [String: String]()
    public var headerParameters = [String: String]()
    public var body: Codable?
    
    open func preCall() {}
    
    open func encodeBody() throws -> Data? {
        return nil
    }

    open func returnFunc(data: Data) throws -> Decodable? {
        return nil
    }

    open func returnFunc(data: Data, contentType: MimeType) throws -> Decodable? {
        return nil
    }

    public init() {
    	self.method = "Get"
    	self.path = ""
    	self.isLongRunningOperation = false
    }
}
