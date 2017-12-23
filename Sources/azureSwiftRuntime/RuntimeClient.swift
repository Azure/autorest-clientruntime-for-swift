//
//  RuntimeClient.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Vladimir Shcherbakov on 11/7/17.
//

import Foundation
import RxSwift

public protocol RuntimeClient {
    func execute(command: BaseCommand) throws -> Decodable?
    func executeAsync<T>(command: BaseCommand) throws -> Observable<T?>
    func executeAsyncLRO(command: BaseCommand, completionHandler: @escaping (Decodable?, Error?)->Void) throws
}
