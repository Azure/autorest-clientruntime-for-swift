/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 */

import Foundation

internal extension AzureClient {
    internal func handleErrorCode(statusCode: Int, data: Data?) throws {
        if statusCode >= 400 {
            if let data_ = data {
                throw RuntimeError.errorStatusCode(code: statusCode, data: data_)
                
            }
        }
    }
}
