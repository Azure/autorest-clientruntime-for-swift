//
//  ImageEncoder.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Alva D Bandy on 12/17/17.
//

import Foundation

public class ImageEncoder : AzureEncoder {
    public func encode<T>(_ value: T) throws -> Data where T : Encodable {
        return Data();
    }
}
