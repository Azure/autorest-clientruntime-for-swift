/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 */

import Foundation

public enum EncodeError: Error {
    case nilInput
    case DataToBase64Failed
    case notString
    case stringToDataFailed
    case unknownMimeType
}

public extension String {
    //: ### Base64 encoding a string
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    func base64uriEncoded() -> String? {
        guard let base64url = self.base64Encoded() else {
            return nil
        }
        
        return base64url
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}

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
