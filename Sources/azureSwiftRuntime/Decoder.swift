//
//  Decoder.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Vladimir Shcherbakov on 12/6/17.
//

import Foundation

public enum DecodeError: Error {
    case dataToString
    case base64
    case base64Url
    case wrongInputType
    case invalidString
    case nilData
    case unknownMimeType
}

public protocol ResponseDecoder {
    static func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

public class JsonResponseDecoder: ResponseDecoder {
    public static func decode<T>(_ type: T.Type, from jsonData: Data) throws -> T where T : Decodable {
        
        // trying to handle a special json case: a keyless quoted string like - "example of invalid json" (even if it's not a valid according to the spec!)
        
        // to return nil instead of emply data down stream
        if jsonData.isEmpty {
            throw DecodeError.nilData
        }
        
        return try CoderFactory.decoder(for: .json).decode(type, from: jsonData)
    }
}

public extension String {
    //: ### Base64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        
        return nil
    }
    func base64uriDecoded() -> String? {
        var base64 = self
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        if base64.count % 4 != 0 {
            base64.append(String(repeating: "=", count: 4 - base64.count % 4))
        }
        
        return base64.base64Decoded()
    }
}
