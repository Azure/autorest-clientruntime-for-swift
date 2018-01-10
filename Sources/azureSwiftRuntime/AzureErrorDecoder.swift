//
//  ErrorDecoder.swift
//  azureSwiftRuntime
//
//  Created by Vladimir Shcherbakov on 1/9/18.
//

import Foundation

public class AzureErrorDecoder<T> where T:Decodable {
    
    var mimeType: MimeType
    
    public init(mimeType: MimeType) {
        self.mimeType = mimeType
    }
    
    public func decode(data: Data) -> T? {
        return try? CoderFactory.decoder(for: self.mimeType).decode(T.self, from: data)
    }
}
