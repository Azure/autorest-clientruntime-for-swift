/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 */

import Foundation

open class BaseCommand {
    public var pathType = PathType.relative
    public var baseUrl: String?
    public var method: String
    public var isLongRunningOperation: Bool
    public var path: String
    public var pathParameters = [String: String]()
    public var queryParameters = [String: String]()
    public var headerParameters = [String: String]()
    public var body: Any?
    
    open func preCall() {}
    
    open func encodeBody() throws -> Data? {
        return nil
    }

    open func returnFunc(data: Data) throws -> Decodable? {
        return nil
    }

    open func returnFunc(data: Data, contentType: MimeType) throws -> Decodable? {
        return nil
    }

    public init() {
    	self.method = "Get"
    	self.path = ""
    	self.isLongRunningOperation = false
    }
}

public enum PathType {
    case relative
    case absolute
}
