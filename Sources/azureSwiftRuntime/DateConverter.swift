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
    
    public func toFormatString() -> String {
        switch self {
        case .dateTimeRfc1123:
            return "EEE, dd MMM yyyy HH:mm:ssZ"
        case .dateTime:
            //return "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
            return "yyyy-MM-dd'T'HH:mm:ss.SZ"
        case .date:
            return "yyyy-MM-dd"
        }
    }
}

public class DateConverter {
    
    static public func toString(date: Date?, format: AzureDate) -> String? {
        return date?.toString(format: format.toFormatString())
    }
    
    static public func fromString(dateStr: String?, format: AzureDate) -> Date? {
        guard let _ = dateStr else {
            return nil
        }
        return Date(fromString: dateStr!, format: format.toFormatString())
    }
}

public extension Date {
    public init?(fromString: String, format: String = "yyyy-MM-dd") {
        let dateFormatter = DateFormatter()
        //let dateFormatter = ISO8601DateFormatter()
        dateFormatter.dateFormat = format
        //dateFormatter.timeZone = TimeZone(identifier: "GMT")
        if let date = dateFormatter.date(from: fromString.uppercased()) {
            self = date
        } else {
            return nil
        }
    }
    
    public func toString(format: String = "yyyy-MM-dd", timezone: TimeZone? = TimeZone(identifier: "GMT")) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timezone
        return dateFormatter.string(from: self)
    }
}

extension String {
    func toDateString( inputDateFormat inputFormat  : String,  ouputDateFormat outputFormat  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date!)
    }
}
