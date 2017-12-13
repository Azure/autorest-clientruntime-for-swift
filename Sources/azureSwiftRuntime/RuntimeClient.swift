//
//  RuntimeClient.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Vladimir Shcherbakov on 11/7/17.
//

import Foundation

public protocol RuntimeClient {
    func execute(command: BaseCommand) throws -> Decodable?
    func executeAsync(command: BaseCommand, completionHandler: @escaping (Decodable?, Error?)->Void) throws
    func executeAsyncLRO(command: BaseCommand, completionHandler: @escaping (Decodable?, Error?)->Void) throws
}
