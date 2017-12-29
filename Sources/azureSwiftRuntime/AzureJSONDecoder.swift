/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 */

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

public class AzureJSONDecoder : JSONDecoder {
    public override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable{// to return nil instead of emply data down stream
        if data.isEmpty {
            throw DecodeError.nilData
        }
        
        if type == Bool?.self || type == Bool.self {
            return try PrimitiveValueDecodingContainer(data).decode(Bool.self) as! T;
        } else if type == Int?.self || type == Int.self {
            return try PrimitiveValueDecodingContainer(data).decode(Int.self) as! T;
        } else if type == Int8?.self || type == Int8.self {
            return try PrimitiveValueDecodingContainer(data).decode(Int8.self) as! T;
        } else if type == Int16?.self || type == Int16.self {
            return try PrimitiveValueDecodingContainer(data).decode(Int16.self) as! T;
        } else if type == Int32?.self || type == Int32.self {
            return try PrimitiveValueDecodingContainer(data).decode(Int32.self) as! T;
        } else if type == Int64?.self || type == Int64.self {
            return try PrimitiveValueDecodingContainer(data).decode(Int64.self) as! T;
        } else if type == UInt?.self || type == UInt.self {
            return try PrimitiveValueDecodingContainer(data).decode(UInt.self) as! T;
        } else if type == UInt8?.self || type == UInt8.self {
            return try PrimitiveValueDecodingContainer(data).decode(UInt8.self) as! T;
        } else if type == UInt16?.self || type == UInt16.self {
            return try PrimitiveValueDecodingContainer(data).decode(UInt16.self) as! T;
        } else if type == UInt32?.self || type == UInt32.self {
            return try PrimitiveValueDecodingContainer(data).decode(UInt32.self) as! T;
        } else if type == UInt64?.self || type == UInt64.self {
            return try PrimitiveValueDecodingContainer(data).decode(UInt64.self) as! T;
        } else if type == Float?.self || type == Float.self {
            return try PrimitiveValueDecodingContainer(data).decode(Float.self) as! T;
        } else if type == Double?.self || type == Double.self {
            return try PrimitiveValueDecodingContainer(data).decode(Double.self) as! T;
        } else if type == String?.self || type == String.self {
            return try PrimitiveValueDecodingContainer(data).decode(String.self) as! T;
        }
        
        return try super.decode(type, from: data);
    }
}

public struct PrimitiveValueDecodingContainer: SingleValueDecodingContainer {
    public var codingPath: [CodingKey]
    var data: String
    
    init(_ data: Data) {
        self.data = String(data: data, encoding: .utf8)!
        codingPath = [];
    }
    
    public func decodeNil() -> Bool {
        return false;
    }
    
    public func decode(_ type: Bool.Type) throws -> Bool {
        return try throwIfNil(Bool.init(self.data));
    }
    
    public func decode(_ type: Int.Type) throws -> Int {
        return try throwIfNil(Int.init(self.data));
    }
    
    public func decode(_ type: Int8.Type) throws -> Int8 {
        return try throwIfNil(Int8.init(self.data));
    }
    
    public func decode(_ type: Int16.Type) throws -> Int16 {
        return try throwIfNil(Int16.init(self.data));
    }
    
    public func decode(_ type: Int32.Type) throws -> Int32 {
        return try throwIfNil(Int32.init(self.data));
    }
    
    public func decode(_ type: Int64.Type) throws -> Int64 {
        return try throwIfNil(Int64.init(self.data));
    }
    
    public func decode(_ type: UInt.Type) throws -> UInt {
        return try throwIfNil(UInt.init(self.data));
    }
    
    public func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try throwIfNil(UInt8.init(self.data));
    }
    
    public func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try throwIfNil(UInt16.init(self.data));
    }
    
    public func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try throwIfNil(UInt32.init(self.data));
    }
    
    public func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try throwIfNil(UInt64.init(self.data));
    }
    
    public func decode(_ type: Float.Type) throws -> Float {
        return try throwIfNil(Float.init(self.data));
    }
    
    public func decode(_ type: Double.Type) throws -> Double {
        return try throwIfNil(Double.init(self.data))
    }
    
    public func decode(_ type: String.Type) throws -> String {
        if(self.data.count >= 2) {
            var endOffset = self.data.index(before: self.data.endIndex)
            if(self.data[self.data.startIndex] == "\"" &&
                self.data[endOffset] == "\"") {
                let startOffset = self.data.index(after: self.data.startIndex)
                endOffset = self.data.index(before: self.data.endIndex)
                return String(self.data[startOffset..<endOffset])
            }
        }
        return self.data;
    }
    
    public func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        throw DecodeError.wrongInputType
    }
    
    func throwIfNil<T>(_ valToCheck: T?) throws -> T where T : Decodable {
        if valToCheck == nil {
            throw DecodeError.nilData
        }
        
        return valToCheck!
    }
}

