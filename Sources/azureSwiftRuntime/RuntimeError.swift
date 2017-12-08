//
//  RuntimeError.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Vladimir Shcherbakov on 11/15/17.
//

import Foundation

public enum RuntimeError: Error {
    case general(message: String)
    case operationFailed
    case operationCanceled
    case azure(error: AzureError)
    case cloud(error: CloudError)
    case errorStatusCode(code: Int, details: String)
}
public struct AzureError: Codable {
    let error: AzureErrorDetails
    
    struct AzureErrorDetails: Codable {
        let code: String
        let message: String
    }
}

public struct CloudError: Codable {
    let status: Int?
    let message: String?
}

