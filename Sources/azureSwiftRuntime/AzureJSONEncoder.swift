//
//  PlainEncoder.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Alva D Bandy on 12/17/17.
//

import Foundation

public class AzureJSONEncoder : JSONEncoder {
    public override func encode<T>(_ value: T?) throws -> Data where T : Encodable {
        if value == nil {
            throw EncodeError.nilInput
        }
        
        if value is Bool ||
            value is Int ||
            value is Int8 ||
            value is Int16 ||
            value is Int32 ||
            value is Int64 ||
            value is UInt ||
            value is UInt8 ||
            value is UInt16 ||
            value is UInt32 ||
            value is UInt64 ||
            value is Float ||
            value is Double {
            return "\(value!)".data(using: .utf8)!
        } else if value is String {
            return "\"\(value as! String)\"".data(using: .utf8)!
        }
        
        return try super.encode(value);
    }
}
