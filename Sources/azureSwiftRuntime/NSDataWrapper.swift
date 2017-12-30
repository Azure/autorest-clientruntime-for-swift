/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 */

import Foundation

public struct NSDataWrapper : Decodable {
    public let data: NSData;
    
    public init(data: Data) {
        self.data = data as NSData;
    }
    
    public init(from decoder: Decoder) throws {
        self.data = NSData()
    }
}
