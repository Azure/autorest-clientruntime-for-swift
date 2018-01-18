//
//  VariousTypes.swift
//  azureSwiftRuntime
//
//  Created by Vladimir Shcherbakov on 1/17/18.
//

import Foundation

struct VariousTypesXML {
    let dictionaryOfInt: [String:Int]?
    let dictionaryOfUInt: [String:UInt]?
    let dictionaryOfFloat: [String:Float]?
    let dictionaryOfDouble: [String:Double]?
    let dictionaryOfString: [String:String?]?
    let dictionaryOfBool: [String:Bool]?
    
    let arrayOfInt: [Int]?
    let arrayOfUInt: [UInt]?
    let arrayOfFloat: [Float]?
    let arrayOfDouble: [Double]?
    let arrayOfString: [String?]?
    
    let dictionaryOfInt8: [String:Int8]?
    let dictionaryOfInt16: [String:Int16]?
    let dictionaryOfInt32: [String:Int32]?
    let dictionaryOfInt64: [String:Int64]?
    
    let dictionaryOfUInt8: [String:UInt8]?
    let dictionaryOfUInt16: [String:UInt16]?
    let dictionaryOfUInt32: [String:UInt32]?
    let dictionaryOfUInt64: [String:UInt64]?
}

extension VariousTypesXML : Decodable {
    enum CodingKeys: String, CodingKey {
        case dictionaryOfInt = "DictionaryOfInt"
        case dictionaryOfUInt = "DictionaryOfUInt"
        case dictionaryOfFloat = "DictionaryOfFloat"
        case dictionaryOfDouble = "DictionaryOfDouble"
        case dictionaryOfString = "DictionaryOfString"
        case dictionaryOfBool = "DictionaryOfBool"
        
        case arrayOfInt = "ArrayOfInt"
        case arrayOfUInt = "ArrayOfUInt"
        case arrayOfFloat = "ArrayOfFloat"
        case arrayOfDouble = "ArrayOfDouble"
        case arrayOfString = "ArrayOfString"
        
        case dictionaryOfInt8 = "DictionaryOfInt8"
        case dictionaryOfInt16 = "DictionaryOfInt16"
        case dictionaryOfInt32 = "DictionaryOfInt32"
        case dictionaryOfInt64 = "DictionaryOfInt64"
        
        case dictionaryOfUInt8 = "DictionaryOfUInt8"
        case dictionaryOfUInt16 = "DictionaryOfUInt16"
        case dictionaryOfUInt32 = "DictionaryOfUInt32"
        case dictionaryOfUInt64 = "DictionaryOfUInt64"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dictionaryOfInt = try container.decode([String:Int]?.self, forKey: .dictionaryOfInt)
        dictionaryOfUInt = try container.decode([String:UInt]?.self, forKey: .dictionaryOfUInt)
        dictionaryOfFloat = try container.decode([String:Float]?.self, forKey: .dictionaryOfFloat)
        dictionaryOfDouble = try container.decode([String:Double]?.self, forKey: .dictionaryOfDouble)
        dictionaryOfString = try container.decode([String:String?]?.self, forKey: .dictionaryOfString)
        dictionaryOfBool = try container.decode([String:Bool]?.self, forKey: .dictionaryOfBool)
        
        arrayOfInt = try container.decode([Int]?.self, forKey: .arrayOfInt)
        arrayOfUInt = try container.decode([UInt]?.self, forKey: .arrayOfUInt)
        arrayOfFloat = try container.decode([Float]?.self, forKey: .arrayOfFloat)
        arrayOfDouble = try container.decode([Double]?.self, forKey: .arrayOfDouble)
        arrayOfString = try container.decode([String?]?.self, forKey: .arrayOfString)
        
        dictionaryOfInt8 = try container.decode([String:Int8]?.self, forKey: .dictionaryOfInt8)
        dictionaryOfInt16 = try container.decode([String:Int16]?.self, forKey: .dictionaryOfInt16)
        dictionaryOfInt32 = try container.decode([String:Int32]?.self, forKey: .dictionaryOfInt32)
        dictionaryOfInt64 = try container.decode([String:Int64]?.self, forKey: .dictionaryOfInt64)
        
        dictionaryOfUInt8 = try container.decode([String:UInt8]?.self, forKey: .dictionaryOfUInt8)
        dictionaryOfUInt16 = try container.decode([String:UInt16]?.self, forKey: .dictionaryOfUInt16)
        dictionaryOfUInt32 = try container.decode([String:UInt32]?.self, forKey: .dictionaryOfUInt32)
        dictionaryOfUInt64 = try container.decode([String:UInt64]?.self, forKey: .dictionaryOfUInt64)
    }
}

let xmlVariousTypes =
"""
<VariousTypes>
<DictionaryOfInt>
    <smallest>-9223372036854775808</smallest>
    <small>-9223372036854775807</small>
    <big>9223372036854775806</big>
    <biggest>9223372036854775807</biggest>
    <random>1234567890</random>
    <zero>0</zero>
</DictionaryOfInt>
<DictionaryOfUInt>
    <smallest>0</smallest>
    <small>1</small>
    <big>18446744073709551614</big>
    <biggest>18446744073709551615</biggest>
    <random>1234567890</random>
    <zero>0</zero>
</DictionaryOfUInt>
<DictionaryOfFloat>
    <smallest>1.175494e-38</smallest>
    <small>1.175494e-37</small>
    <big>3.402823e+37</big>
    <biggest>3.402823e+38</biggest>
    <random>2.123457</random>
    <zero>0.000000</zero>
</DictionaryOfFloat>
<DictionaryOfDouble>
    <smallest>2.225073858507201e-308</smallest>
    <small>2.225073858507201e-307</small>
    <big>2.225073858507201e-307</big>
    <biggest>2.225073858507201e-308</biggest>
    <random>2.123456789012346</random>
    <zero>0.000000000000000</zero>
</DictionaryOfDouble>
<DictionaryOfString>
    <upper>UPPER CASED STRING</upper>
    <lower>lower cased string</lower>
    <numbers>2.225073858507201e-308</numbers>
    <symbols>@#$%^*()_+</symbols>
    <random>Aa23$$</random>
    <empty></empty>
</DictionaryOfString>
<DictionaryOfBool>
    <hi>true</hi>
    <lo>false</lo>
</DictionaryOfBool>

<DictionaryOfInt8>
    <smallest>-128</smallest>
    <biggest>127</biggest>
</DictionaryOfInt8>
<DictionaryOfInt16>
    <smallest>-32768</smallest>
    <biggest>32767</biggest>
</DictionaryOfInt16>
<DictionaryOfInt32>
    <smallest>-2147483648</smallest>
    <biggest>2147483647</biggest>
</DictionaryOfInt32>
<DictionaryOfInt64>
    <smallest>-9223372036854775808</smallest>
    <biggest>9223372036854775807</biggest>
</DictionaryOfInt64>

<DictionaryOfUInt8>
    <smallest>0</smallest>
    <biggest>255</biggest>
</DictionaryOfUInt8>
<DictionaryOfUInt16>
    <smallest>0</smallest>
    <biggest>65535</biggest>
</DictionaryOfUInt16>
<DictionaryOfUInt32>
    <smallest>0</smallest>
    <biggest>4294967295</biggest>
</DictionaryOfUInt32>
<DictionaryOfUInt64>
    <smallest>0</smallest>
    <biggest>18446744073709551615</biggest>
</DictionaryOfUInt64>

<ArrayOfInt>
<value>-9223372036854775807</value>
<value>9223372036854775806</value>
<value>-9223372036854775808</value>
<value>9223372036854775807</value>
<value>1234567890</value>
<value>0</value>
</ArrayOfInt>
<ArrayOfUInt>
<value>18446744073709551615</value>
<value>18446744073709551614</value>
<value>0</value>
<value>1</value>
<value>1234567890</value>
<value>0</value>
</ArrayOfUInt>
<ArrayOfFloat>
<value>3.402823e+38</value>
<value>3.402823e+37</value>
<value>1.175494e-38</value>
<value>1.175494e-37</value>
<value>2.123457</value>
<value>0.000000</value>
</ArrayOfFloat>
<ArrayOfDouble>
<value>2.225073858507201e-308</value>
<value>2.225073858507201e-307</value>
<value>2.225073858507201e-308</value>
<value>2.225073858507201e-307</value>
<value>2.123456789012346</value>
<value>0.000000000000000</value>
</ArrayOfDouble>
<ArrayOfString>
<value>UPPER CASED STRING</value>
<value>lower cased string</value>
<value>2.225073858507201e-308</value>
<value>@#$%^*()_+</value>
<value>Aa23$$</value>
<value></value>
</ArrayOfString>
</VariousTypes>
"""
