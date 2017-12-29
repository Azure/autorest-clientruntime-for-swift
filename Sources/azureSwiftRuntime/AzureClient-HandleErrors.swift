/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 */

import Foundation

internal extension AzureClient {
    internal func handleErrorCode(statusCode: Int, data: Data?) throws {
        if statusCode >= 400 {
            if let jsonData = data {
                if jsonData.count == 0 {
                    throw RuntimeError.errorStatusCode(code: statusCode, details: "no details")
                }
                
                if let cloudError = try? CoderFactory.decoder(for: .json)
                        .decode(CloudError.self, from: jsonData) {
                    throw RuntimeError.cloud(error: cloudError)
                } else {
                    if let cloudError = try? AzureJSONDecoder().decode(CloudError.self, from: jsonData) {
                        throw RuntimeError.cloud(error: cloudError)
                    } else {
                        let str = String(data: jsonData, encoding: .utf8)
                        throw RuntimeError.errorStatusCode(code: statusCode, details: str ?? "can't get details")
                    }
                }
            }
        }
    }
}
