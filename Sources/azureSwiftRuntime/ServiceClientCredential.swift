//
//  ServiceClientCredential.swift
//  azureSwiftRuntimeTests
//
//  Created by Vladimir Shcherbakov on 12/12/17.
//

import Foundation

protocol ServiceClientCredential {
    func authHeaderValue(url: String?) throws -> String
}
