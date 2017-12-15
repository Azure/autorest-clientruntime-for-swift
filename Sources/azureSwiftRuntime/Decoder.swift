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
    case nilString
    case nilData
}

public protocol ResponseDecoder {
    static func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

public class JsonResponseDecoder: ResponseDecoder {
    public static func decode<T>(_ type: T.Type, from jsonData: Data) throws -> T where T : Decodable {
        
        // trying to handle a special json case: a keyless quoted string like - "example of invalid json" (even if it's not a valid according to the spec!)
        
        if jsonData.isEmpty {
            throw DecodeError.nilString
        }
        
        if let _ = try? JSONSerialization.jsonObject(with: jsonData) {
            //print("test:", test)
            let test = try JSONDecoder().decode(type, from: jsonData)
            return test
        } else {
            let test = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! T
            return test
        }
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
