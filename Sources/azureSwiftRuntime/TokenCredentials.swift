//
//  TokenCredentials.swift
//  azureSwiftRuntimeTests
//
//  Created by Vladimir Shcherbakov on 12/12/17.
//

import Foundation

protocol TokenCredentials: ServiceClientCredential {
    func getToken(forResource: String) throws -> String
}