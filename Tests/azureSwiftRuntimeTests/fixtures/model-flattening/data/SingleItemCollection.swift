//
//  SingleItemCollection.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Vladimir Shcherbakov on 1/19/18.
//

import Foundation

struct SingleItemCollection: Decodable {
    let array: [String]
    let map: [String:String]
    let arrayOp: [String?]
    let mapOp: [String:String?]
    let arrayOpEmpty: [String?]
    let mapOpEmpty: [String:String?]
}

let xmlSingleItemCollection =
"""
<collection>
    <array>
        <string>Hello</string>
    </array>
    <map>
        <string>Hello</string>
    </map>
    <arrayOp>
        <string>Hello</string>
    </arrayOp>
    <mapOp>
        <string>Hello</string>
    </mapOp>
    <arrayOpEmpty>
        <string></string>
    </arrayOpEmpty>
    <mapOpEmpty>
        <string></string>
    </mapOpEmpty>
</collection>
"""

