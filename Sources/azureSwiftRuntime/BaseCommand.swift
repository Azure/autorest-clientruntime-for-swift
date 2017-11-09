//
//  BaseCommand.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Vladimir Shcherbakov on 11/7/17.
//

import Foundation

public protocol ResponseDecoder {
    func decode<T>(_ type: T.Type, from jsonString: String) throws -> T where T : Decodable
}

public class BaseCommand {
    var method: String
    var isLongRunningOperation: Bool
    var path: String
    var pathParameters = [String: String]()
    var queryParameters = [String: String]()
    var headerParameters = [String: String]()
    
    func preCall() {

    }

    func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
    	return nil;
    }

    init() {
    	self.method = "Get"
    	self.path = ""
    	self.isLongRunningOperation = false
    }
}
