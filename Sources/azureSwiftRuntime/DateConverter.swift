/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 */

import Foundation

public enum AzureDate : String {
    case dateTimeRfc1123 = "date-time-rfc1123"
    case dateTime = "date-time"
    case date = "date"
}

public class DateConverter {
    static public func toString(date: Date?, format: AzureDate) -> String? {
        return nil;
    }

    static public func fromString(dateStr: String?, format: AzureDate) -> Date? {
        return nil;
    }
}
