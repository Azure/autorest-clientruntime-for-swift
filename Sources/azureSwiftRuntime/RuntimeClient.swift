//
//  RuntimeClient.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Vladimir Shcherbakov on 11/7/17.
//

import Foundation
import RxSwift

public protocol RuntimeClient {
    func executeAsync<T>(command: BaseCommand) -> Observable<T?> where T : Decodable
    func executeAsync<T>(command: BaseCommand, completionHandler: @escaping (T?, Error?)->Void) where T : Decodable
    func executeAsyncLRO(command: BaseCommand, completionHandler: @escaping (Decodable?, Error?)->Void)
    func execute(command: BaseCommand) throws -> Decodable?
}
