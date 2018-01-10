/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 */

import Foundation

public enum RuntimeError: Error {
    case general(message: String)
    case operationFailed
    case operationCanceled
    case errorStatusCode(code: Int, data: Data)
    case invalidData
}

public struct CloudError: Codable {
    public let status: Int?
    public let message: String?
}

