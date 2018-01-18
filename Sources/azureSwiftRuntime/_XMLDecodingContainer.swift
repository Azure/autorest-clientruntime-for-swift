//
//  _XMLKeyedDecodingContainer.swift
//  azureSwiftRuntime
//
//  Created by Vladimir Shcherbakov on 1/17/18.
//

import Foundation
internal struct _XMLKeyedDecodingContainer<K : CodingKey> : KeyedDecodingContainerProtocol {
    typealias Key = K
    
    // MARK: Properties
    
    /// A reference to the decoder we're reading from.
    private let decoder: _XMLDecoder
    
    /// A reference to the container we're reading from.
    private let container: [String : Any]
    
    /// The path of coding keys taken to get to this point in decoding.
    private(set) public var codingPath: [CodingKey]
    
    // MARK: - Initialization
    
    /// Initializes `self` by referencing the given decoder and container.
    internal init(referencing decoder: _XMLDecoder, wrapping container: [String : Any]) {
        self.decoder = decoder
        self.container = container
        self.codingPath = decoder.codingPath
    }
    
    // MARK: - KeyedDecodingContainerProtocol Methods
    
    public var allKeys: [Key] {
        return self.container.keys.map { Key(stringValue: $0)! }
    }
    
    public func contains(_ key: Key) -> Bool {
        return self.container[key.stringValue] != nil
    }
    
    public func decodeNil(forKey key: Key) throws -> Bool {
        guard let entry = self.container[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."))
        }
        
        return entry is NSNull
    }
    
    public func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        guard let entry = self.container[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."))
        }
        
        return try self.decoder.with(pushedKey: key) {
            guard let value = try self.decoder.unbox(entry, as: Bool.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "Expected \(type) value but found null instead."))
            }
            
            return value
        }
    }
    
    public func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        guard let entry = self.container[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."))
        }
        
        return try self.decoder.with(pushedKey: key) {
            guard let value = try self.decoder.unbox(entry, as: Int.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "Expected \(type) value but found null instead."))
            }
            
            return value
        }
    }
    
    public func decode(_ type: Int?.Type, forKey key: Key) throws -> Int? {
        guard let entry = self.container[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."))
        }
        
        if entry == nil {return nil}
        
        return try self.decoder.with(pushedKey: key) {
            guard let value = try self.decoder.unbox(entry, as: Int.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "Expected \(type) value but found null instead."))
            }
            
            return value
        }
    }
    
    public func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        guard let entry = self.container[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."))
        }
        
        return try self.decoder.with(pushedKey: key) {
            guard let value = try self.decoder.unbox(entry, as: Int8.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "Expected \(type) value but found null instead."))
            }
            
            return value
        }
    }
    
    public func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        guard let entry = self.container[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."))
        }
        
        return try self.decoder.with(pushedKey: key) {
            guard let value = try self.decoder.unbox(entry, as: Int16.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "Expected \(type) value but found null instead."))
            }
            
            return value
        }
    }
    
    public func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        guard let entry = self.container[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."))
        }
        
        return try self.decoder.with(pushedKey: key) {
            guard let value = try self.decoder.unbox(entry, as: Int32.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "Expected \(type) value but found null instead."))
            }
            
            return value
        }
    }
    
    public func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        guard let entry = self.container[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."))
        }
        
        return try self.decoder.with(pushedKey: key) {
            guard let value = try self.decoder.unbox(entry, as: Int64.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "Expected \(type) value but found null instead."))
            }
            
            return value
        }
    }
    
    public func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        guard let entry = self.container[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."))
        }
        
        return try self.decoder.with(pushedKey: key) {
            guard let value = try self.decoder.unbox(entry, as: UInt.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "Expected \(type) value but found null instead."))
            }
            
            return value
        }
    }
    
    public func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        guard let entry = self.container[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."))
        }
        
        return try self.decoder.with(pushedKey: key) {
            guard let value = try self.decoder.unbox(entry, as: UInt8.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "Expected \(type) value but found null instead."))
            }
            
            return value
        }
    }
    
    public func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        guard let entry = self.container[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."))
        }
        
        return try self.decoder.with(pushedKey: key) {
            guard let value = try self.decoder.unbox(entry, as: UInt16.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "Expected \(type) value but found null instead."))
            }
            
            return value
        }
    }
    
    public func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        guard let entry = self.container[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."))
        }
        
        return try self.decoder.with(pushedKey: key) {
            guard let value = try self.decoder.unbox(entry, as: UInt32.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "Expected \(type) value but found null instead."))
            }
            
            return value
        }
    }
    
    public func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        guard let entry = self.container[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."))
        }
        
        return try self.decoder.with(pushedKey: key) {
            guard let value = try self.decoder.unbox(entry, as: UInt64.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "Expected \(type) value but found null instead."))
            }
            
            return value
        }
    }
    
    public func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        guard let entry = self.container[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."))
        }
        
        return try self.decoder.with(pushedKey: key) {
            guard let value = try self.decoder.unbox(entry, as: Float.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "Expected \(type) value but found null instead."))
            }
            
            return value
        }
    }
    
    public func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        guard let entry = self.container[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."))
        }
        
        return try self.decoder.with(pushedKey: key) {
            guard let value = try self.decoder.unbox(entry, as: Double.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "Expected \(type) value but found null instead."))
            }
            
            return value
        }
    }
    
    public func decode(_ type: String.Type, forKey key: Key) throws -> String {
        guard let entry = self.container[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."))
        }
        
        return try self.decoder.with(pushedKey: key) {
            guard let value = try self.decoder.unbox(entry, as: String.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "Expected \(type) value but found null instead."))
            }
            
            return value
        }
    }
    
    public func decode<T : Decodable>(_ type: T.Type, forKey key: Key) throws -> T {
        guard let entry = self.container[key.stringValue] else {
            throw DecodingError.keyNotFound(key, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "No value associated with key \(key) (\"\(key.stringValue)\")."))
        }
        
        return try self.decoder.with(pushedKey: key) {
            guard let value = try self.decoder.unbox(entry, as: T.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "Expected \(type) value but found null instead."))
            }
            
            return value
        }
    }
    
    public func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> {
        return try self.decoder.with(pushedKey: key) {
            guard let value = self.container[key.stringValue] else {
                throw DecodingError.keyNotFound(key,
                                                DecodingError.Context(codingPath: self.codingPath,
                                                                      debugDescription: "Cannot get \(KeyedDecodingContainer<NestedKey>.self) -- no value found for key \"\(key.stringValue)\""))
            }
            
            guard let dictionary = value as? [String : Any] else {
                throw DecodingError._typeMismatch(at: self.codingPath, expectation: [String : Any].self, reality: value)
            }
            
            let container = _XMLKeyedDecodingContainer<NestedKey>(referencing: self.decoder, wrapping: dictionary)
            return KeyedDecodingContainer(container)
        }
    }
    
    public func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        return try self.decoder.with(pushedKey: key) {
            guard let value = self.container[key.stringValue] else {
                throw DecodingError.keyNotFound(key,
                                                DecodingError.Context(codingPath: self.codingPath,
                                                                      debugDescription: "Cannot get UnkeyedDecodingContainer -- no value found for key \"\(key.stringValue)\""))
            }
            
            guard let array = value as? [Any] else {
                throw DecodingError._typeMismatch(at: self.codingPath, expectation: [Any].self, reality: value)
            }
            
            return _XMLUnkeyedDecodingContainer(referencing: self.decoder, wrapping: array)
        }
    }
    
    private func _superDecoder(forKey key: CodingKey) throws -> Decoder {
        return self.decoder.with(pushedKey: key) {
            let value: Any = self.container[key.stringValue] ?? NSNull()
            return _XMLDecoder(referencing: value, at: self.decoder.codingPath, options: self.decoder.options)
        }
    }
    
    public func superDecoder() throws -> Decoder {
        return try _superDecoder(forKey: _XMLKey.super)
    }
    
    public func superDecoder(forKey key: Key) throws -> Decoder {
        return try _superDecoder(forKey: key)
    }
}

internal struct _XMLUnkeyedDecodingContainer : UnkeyedDecodingContainer {
    // MARK: Properties
    
    /// A reference to the decoder we're reading from.
    private let decoder: _XMLDecoder
    
    /// A reference to the container we're reading from.
    private let container: [Any]
    
    /// The path of coding keys taken to get to this point in decoding.
    private(set) public var codingPath: [CodingKey]
    
    /// The index of the element we're about to decode.
    private(set) public var currentIndex: Int
    
    // MARK: - Initialization
    
    /// Initializes `self` by referencing the given decoder and container.
    internal init(referencing decoder: _XMLDecoder, wrapping container: [Any]) {
        self.decoder = decoder
        self.container = container
        self.codingPath = decoder.codingPath
        self.currentIndex = 0
    }
    
    // MARK: - UnkeyedDecodingContainer Methods
    
    public var count: Int? {
        return self.container.count
    }
    
    public var isAtEnd: Bool {
        return self.currentIndex >= self.count!
    }
    
    public mutating func decodeNil() throws -> Bool {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(Any?.self, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Unkeyed container is at end."))
        }
        
        if self.container[self.currentIndex] is NSNull {
            self.currentIndex += 1
            return true
        } else {
            return false
        }
    }
    
    public mutating func decode(_ type: Bool.Type) throws -> Bool {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Unkeyed container is at end."))
        }
        
        return try self.decoder.with(pushedKey: _XMLKey(index: self.currentIndex)) {
            guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: Bool.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Expected \(type) but found null instead."))
            }
            
            self.currentIndex += 1
            return decoded
        }
    }
    
    public mutating func decode(_ type: Int.Type) throws -> Int {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Unkeyed container is at end."))
        }
        
        return try self.decoder.with(pushedKey: _XMLKey(index: self.currentIndex)) {
            guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: Int.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Expected \(type) but found null instead."))
            }
            
            self.currentIndex += 1
            return decoded
        }
    }
    
    public mutating func decode(_ type: Int8.Type) throws -> Int8 {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Unkeyed container is at end."))
        }
        
        return try self.decoder.with(pushedKey: _XMLKey(index: self.currentIndex)) {
            guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: Int8.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Expected \(type) but found null instead."))
            }
            
            self.currentIndex += 1
            return decoded
        }
    }
    
    public mutating func decode(_ type: Int16.Type) throws -> Int16 {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Unkeyed container is at end."))
        }
        
        return try self.decoder.with(pushedKey: _XMLKey(index: self.currentIndex)) {
            guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: Int16.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Expected \(type) but found null instead."))
            }
            
            self.currentIndex += 1
            return decoded
        }
    }
    
    public mutating func decode(_ type: Int32.Type) throws -> Int32 {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Unkeyed container is at end."))
        }
        
        return try self.decoder.with(pushedKey: _XMLKey(index: self.currentIndex)) {
            guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: Int32.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Expected \(type) but found null instead."))
            }
            
            self.currentIndex += 1
            return decoded
        }
    }
    
    public mutating func decode(_ type: Int64.Type) throws -> Int64 {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Unkeyed container is at end."))
        }
        
        return try self.decoder.with(pushedKey: _XMLKey(index: self.currentIndex)) {
            guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: Int64.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Expected \(type) but found null instead."))
            }
            
            self.currentIndex += 1
            return decoded
        }
    }
    
    public mutating func decode(_ type: UInt.Type) throws -> UInt {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Unkeyed container is at end."))
        }
        
        return try self.decoder.with(pushedKey: _XMLKey(index: self.currentIndex)) {
            guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: UInt.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Expected \(type) but found null instead."))
            }
            
            self.currentIndex += 1
            return decoded
        }
    }
    
    public mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Unkeyed container is at end."))
        }
        
        return try self.decoder.with(pushedKey: _XMLKey(index: self.currentIndex)) {
            guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: UInt8.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Expected \(type) but found null instead."))
            }
            
            self.currentIndex += 1
            return decoded
        }
    }
    
    public mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Unkeyed container is at end."))
        }
        
        return try self.decoder.with(pushedKey: _XMLKey(index: self.currentIndex)) {
            guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: UInt16.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Expected \(type) but found null instead."))
            }
            
            self.currentIndex += 1
            return decoded
        }
    }
    
    public mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Unkeyed container is at end."))
        }
        
        return try self.decoder.with(pushedKey: _XMLKey(index: self.currentIndex)) {
            guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: UInt32.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Expected \(type) but found null instead."))
            }
            
            self.currentIndex += 1
            return decoded
        }
    }
    
    public mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Unkeyed container is at end."))
        }
        
        return try self.decoder.with(pushedKey: _XMLKey(index: self.currentIndex)) {
            guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: UInt64.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Expected \(type) but found null instead."))
            }
            
            self.currentIndex += 1
            return decoded
        }
    }
    
    public mutating func decode(_ type: Float.Type) throws -> Float {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Unkeyed container is at end."))
        }
        
        return try self.decoder.with(pushedKey: _XMLKey(index: self.currentIndex)) {
            guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: Float.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Expected \(type) but found null instead."))
            }
            
            self.currentIndex += 1
            return decoded
        }
    }
    
    public mutating func decode(_ type: Double.Type) throws -> Double {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Unkeyed container is at end."))
        }
        
        return try self.decoder.with(pushedKey: _XMLKey(index: self.currentIndex)) {
            guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: Double.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Expected \(type) but found null instead."))
            }
            
            self.currentIndex += 1
            return decoded
        }
    }
    
    public mutating func decode(_ type: String.Type) throws -> String {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Unkeyed container is at end."))
        }
        
        return try self.decoder.with(pushedKey: _XMLKey(index: self.currentIndex)) {
            guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: String.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Expected \(type) but found null instead."))
            }
            
            self.currentIndex += 1
            return decoded
        }
    }
    
    public mutating func decode<T : Decodable>(_ type: T.Type) throws -> T {
        guard !self.isAtEnd else {
            throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Unkeyed container is at end."))
        }
        
        return try self.decoder.with(pushedKey: _XMLKey(index: self.currentIndex)) {
            guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: T.self) else {
                throw DecodingError.valueNotFound(type, DecodingError.Context(codingPath: self.decoder.codingPath + [_XMLKey(index: self.currentIndex)], debugDescription: "Expected \(type) but found null instead."))
            }
            
            self.currentIndex += 1
            return decoded
        }
    }
    
    public mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> {
        return try self.decoder.with(pushedKey: _XMLKey(index: self.currentIndex)) {
            guard !self.isAtEnd else {
                throw DecodingError.valueNotFound(KeyedDecodingContainer<NestedKey>.self,
                                                  DecodingError.Context(codingPath: self.codingPath,
                                                                        debugDescription: "Cannot get nested keyed container -- unkeyed container is at end."))
            }
            
            let value = self.container[self.currentIndex]
            guard !(value is NSNull) else {
                throw DecodingError.valueNotFound(KeyedDecodingContainer<NestedKey>.self,
                                                  DecodingError.Context(codingPath: self.codingPath,
                                                                        debugDescription: "Cannot get keyed decoding container -- found null value instead."))
            }
            
            guard let dictionary = value as? [String : Any] else {
                throw DecodingError._typeMismatch(at: self.codingPath, expectation: [String : Any].self, reality: value)
            }
            
            self.currentIndex += 1
            let container = _XMLKeyedDecodingContainer<NestedKey>(referencing: self.decoder, wrapping: dictionary)
            return KeyedDecodingContainer(container)
        }
    }
    
    public mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        return try self.decoder.with(pushedKey: _XMLKey(index: self.currentIndex)) {
            guard !self.isAtEnd else {
                throw DecodingError.valueNotFound(UnkeyedDecodingContainer.self,
                                                  DecodingError.Context(codingPath: self.codingPath,
                                                                        debugDescription: "Cannot get nested keyed container -- unkeyed container is at end."))
            }
            
            let value = self.container[self.currentIndex]
            guard !(value is NSNull) else {
                throw DecodingError.valueNotFound(UnkeyedDecodingContainer.self,
                                                  DecodingError.Context(codingPath: self.codingPath,
                                                                        debugDescription: "Cannot get keyed decoding container -- found null value instead."))
            }
            
            guard let array = value as? [Any] else {
                throw DecodingError._typeMismatch(at: self.codingPath, expectation: [Any].self, reality: value)
            }
            
            self.currentIndex += 1
            return _XMLUnkeyedDecodingContainer(referencing: self.decoder, wrapping: array)
        }
    }
    
    public mutating func superDecoder() throws -> Decoder {
        return try self.decoder.with(pushedKey: _XMLKey(index: self.currentIndex)) {
            guard !self.isAtEnd else {
                throw DecodingError.valueNotFound(Decoder.self,
                                                  DecodingError.Context(codingPath: self.codingPath,
                                                                        debugDescription: "Cannot get superDecoder() -- unkeyed container is at end."))
            }
            
            let value = self.container[self.currentIndex]
            self.currentIndex += 1
            return _XMLDecoder(referencing: value, at: self.decoder.codingPath, options: self.decoder.options)
        }
    }
}
