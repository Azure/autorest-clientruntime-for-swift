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
    
    static let azureToSwiftFormat: [AzureDate:String] = [
        .dateTimeRfc1123 : "EEE, dd MMM yyyy HH:mm:ss z",   // Fri, 31 Dec 9999 23:59:59 GMT
        .dateTime : "yyyy-MM-ddTHH:mm:ssZ",                 // 9999-12-31T23:59:59.9999999Z
        .date : "yyyy-MM-dd",                               // 9999-12-31
    ]
    
    static public func toString(date: Date?, format: AzureDate) -> String? {
        return date?.toString(format: azureToSwiftFormat[format]!)
    }
    
    static public func fromString(dateStr: String?, format: AzureDate) -> Date? {
        guard let _ = dateStr else {
            return nil
        }
        return Date(fromString: dateStr!, format: azureToSwiftFormat[format]!)
    }
}

public extension Date {
    public init?(fromString: String, format: String = "yyyy-MM-dd") {
        let dateFormatter = DateFormatter()
        //let dateFormatter = ISO8601DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: fromString) {
            self = date
        } else {
            return nil
        }
    }
    
    public func toString(format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
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
