/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 */

import Foundation

public enum MimeType : String {
    case json = "application/json"
    case xml = "application/xml"
    case plain = "text/plain"
    case png = "image/png"
    case jpeg = "image/jpeg"
    case gif = "image/gif"
    case unknown = "unknown"
    
    public static func getType(forStr: String) -> MimeType? {
        let mimeType = MimeType.init(rawValue: forStr);
        return mimeType
    }
}
