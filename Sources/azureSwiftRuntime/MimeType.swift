//
//  MimeType.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Alva D Bandy on 12/17/17.
//

import Foundation

public enum MimeType : String {
    case json = "application/json"
    case xml = "application/xml"
    case plain = "text/plain"
    case png = "image/png"
    case jpeg = "image/jpeg"
    case gif = "image/gif"
    case unknown = "unknown"
    
    static func getType(forStr: String) -> MimeType? {
        let mimeType = MimeType.init(rawValue: forStr);
        return mimeType
    }
}
