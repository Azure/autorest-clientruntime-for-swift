//
//  DateConverter.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Alva D Bandy on 12/29/17.
//

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
