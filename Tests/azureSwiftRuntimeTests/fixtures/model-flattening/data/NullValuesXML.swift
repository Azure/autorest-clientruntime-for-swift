//
//  NullValuesXML.swift
//  azureSwiftRuntime
//
//  Created by Vladimir Shcherbakov on 1/17/18.
//

import Foundation

struct NullValuesXML {
    let string: String?
    let float: Float?
    let double: Double?
    let bool : Bool?
    let int : Int?
    let date : Date?
    
    let string1: String?
    let float1: Float?
    let double1: Double?
    let bool1: Bool?
    let int1: Int?
    let date1 : Date?
}

let xmlNullValuesXML =
"""
<NullValuesXML>
    <string></string>
    <float></float>
    <double></double>
    <bool></bool>
    <int></int>
    <date></date>
    <string1>AS23@#</string1>
    <float1>1.12345</float1>
    <double1>1.123456789012345</double1>
    <bool1>true</bool1>
    <int1>45689</int1>
    <date1>Thu, 18 Jan 2018 02:01:17 GMT</date1>
</NullValuesXML>
"""

extension NullValuesXML : Decodable {
    enum CodingKeys: String, CodingKey {
        case string = "string"
        case float = "float"
        case double = "double"
        case bool = "bool"
        case int = "int"
        case date = "date"
        case string1 = "string1"
        case float1 = "float1"
        case double1 = "double1"
        case bool1 = "bool1"
        case int1 = "int1"
        case date1 = "date1"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        string = try container.decode(String?.self, forKey: .string)
        float = try container.decode(Float?.self, forKey: .float)
        double = try container.decode(Double?.self, forKey: .double)
        bool = try container.decode(Bool?.self, forKey: .bool)
        int = try container.decode(Int?.self, forKey: .int)
        date = try container.decode(Date?.self, forKey: .date)
        
        string1 = try container.decode(String?.self, forKey: .string1)
        float1 = try container.decode(Float?.self, forKey: .float1)
        double1 = try container.decode(Double?.self, forKey: .double1)
        bool1 = try container.decode(Bool?.self, forKey: .bool1)
        int1 = try container.decode(Int?.self, forKey: .int1)
        date1 = try container.decode(Date?.self, forKey: .date1)
    }
}

let jsonNullValuesXML =
"""
{
"string" :,
""
}
"""
