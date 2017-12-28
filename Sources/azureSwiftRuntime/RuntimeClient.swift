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
    
    // non-blocking
    func executeAsync<T>(command: BaseCommand, completionHandler: @escaping (T?, Error?)->Void) where T : Decodable
    
    // non-blocking, no return value - just error
    func executeAsync(command: BaseCommand, completionHandler: @escaping (Error?)->Void)
    
    // long-running
    func executeAsyncLRO<T>(command: BaseCommand, completionHandler: @escaping (T?, Error?)->Void) where T : Decodable
    
    // long-running, no return value - just error
    func executeAsyncLRO(command: BaseCommand, completionHandler: @escaping (Error?)->Void)
    
    // blocking
    func execute(command: BaseCommand) throws -> Decodable?
}
