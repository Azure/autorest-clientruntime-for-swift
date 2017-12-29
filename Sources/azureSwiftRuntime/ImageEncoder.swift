/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 */

import Foundation

public class ImageEncoder : AzureEncoder {
    public func encode<T>(_ value: T) throws -> Data where T : Encodable {
        return Data();
    }
}
