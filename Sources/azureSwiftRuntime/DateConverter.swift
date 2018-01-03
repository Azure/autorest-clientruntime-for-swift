/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 */

import Foundation

public enum DateFormat: String {
    case rfc1123 = "EEE, dd MMM yyyy HH:mm:ssZ"
    case iso8601DateTime = "yyyy-MM-dd'T'HH:mm:ssZ"
    case iso8601DateTimeMs = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
    case iso8601Date = "yyyy-MM-dd"
}

public enum AzureDateFormat : String {
    case dateTimeRfc1123 = "date-time-rfc1123"
    case dateTime = "date-time"
    case date = "date"
    
    public func toFormatString() -> String {
        switch self {
        case .dateTimeRfc1123:
            return DateFormat.rfc1123.rawValue
        case .dateTime:
            return DateFormat.iso8601DateTime.rawValue
        case .date:
            return DateFormat.iso8601Date.rawValue
        }
    }
    
    public func toString(date: Date, timezone: TimeZone? = TimeZone(identifier: "GMT")) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self.toFormatString()
        dateFormatter.timeZone = timezone
        return dateFormatter.string(from: date)
    }
    
    public func toDate(dateStr: String) -> Date? {
        let dateFormatter = DateFormatter()
        switch self {
        case .dateTime:
            if dateStr.range(of: ".") == nil {
                dateFormatter.dateFormat = DateFormat.iso8601DateTime.rawValue
            } else {
                dateFormatter.dateFormat = DateFormat.iso8601DateTimeMs.rawValue
            }
        default:
            dateFormatter.dateFormat = self.toFormatString()
        }
        
        return dateFormatter.date(from: dateStr)
    }
}

public class DateConverter {
    
    static public func toString(date: Date?, format: AzureDateFormat) -> String? {
        guard let _ = date else {
            return nil
        }
        return format.toString(date: date!)
    }
    
    static public func fromString(dateStr: String?, format: AzureDateFormat) -> Date? {
        guard let _ = dateStr else {
            return nil
        }
        return Date(fromString: dateStr!, format: format)
    }
}

public extension Date {
    public init?(fromString: String, format: AzureDateFormat) {
        let dateStr = fromString.uppercased()
        if let date = format.toDate(dateStr: dateStr) {
            self = date
        } else {
            return nil
        }
    }
}
