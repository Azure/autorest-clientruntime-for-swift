//
//  BaseCommand.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Vladimir Shcherbakov on 11/7/17.
//

import Foundation

protocol ResponseDecoder {
    func decode<T>(_ type: T.Type, from jsonString: String) throws -> T where T : Decodable
}

protocol BaseCommand {
    var method: String { get }
    var isLongRunningOperation: Bool { get }
    var path: String { get }
    var pathParameters: [String: String] { get }
    var queryParameters: [String: String] { get }
    var headerParameters: [String: String] { get }
    func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable?
}
