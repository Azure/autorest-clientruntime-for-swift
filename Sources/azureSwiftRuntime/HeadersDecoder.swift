//
//  MapDecoder.swift
//  azureSwiftRuntime
//
//  Created by Vladimir Shcherbakov on 1/25/18.
//

import Foundation

open class HeadersDecoder: XMLDecoder {
    open func decode<T : Decodable>(_ type: T.Type, from headers: [String:String]) throws -> T {
        let decoder = _XMLDecoder(referencing: headers, options: self.options)
        return try T(from: decoder)
    }
}
