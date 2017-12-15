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
    public let error: AzureErrorDetails
    
    public struct AzureErrorDetails: Codable {
        let code: String
        let message: String
    }
}

public struct CloudError: Codable {
    public let status: Int?
    public let message: String?
}

