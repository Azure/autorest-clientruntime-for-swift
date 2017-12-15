//
//  Encoder.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Vladimir Shcherbakov on 12/6/17.
//

import Foundation

public enum EncodeError: Error {
    case nilInput
    case DataToBase64Failed
    case notString
    case stringTpDataFailed
}

public protocol RequestEncoder {
    static func encode<T>(encodable: T?) throws -> Data where T:Encodable
}

public struct JsonRequestEncoder: RequestEncoder {
    public static func encode<T>(encodable: T?) throws -> Data where T:Encodable {
        guard let e = encodable else {
            throw EncodeError.nilInput
        }
        
        var d: Data? = nil
        
        if e is String {
            let str = e as! String
            let qstr = "\"\(str)\""
            d = qstr.data(using: .utf8)
        } else if e is Int
            || e is Float
            || e is Double
            || e is Bool {
            let str = String(describing: e)
            d = str.data(using: .utf8)
        } else {
            d = try JSONEncoder().encode(e)
        }
        
        guard let data = d else {
            throw EncodeError.stringTpDataFailed
        }
        
        return data
    }
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


