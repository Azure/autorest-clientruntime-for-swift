//
//  SingleItemCollection.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Vladimir Shcherbakov on 1/19/18.
//

import Foundation

struct SingleItemCollection<T:Decodable>: Decodable {
    let arrayType: [T]
    let mapType: [String:T]
    let arrayTypeOp: [T?]
    let mapTypeOp: [String:T?]
    let arrayTypeOpEmpty: [T?]
    let mapTypeOpEmpty: [String:T?]
    let arrayOpTypeOp: [T?]?
    let mapOpTypeOp: [String:T?]?
}

let xmlSingleItemCollection =
"""
<collection>
    <arrayType>
        <val>$</val>
    </arrayType>
    <mapType>
        <val>$</val>
    </mapType>
    <arrayTypeOp>
        <val>$</val>
    </arrayTypeOp>
    <mapTypeOp>
        <val>$</val>
    </mapTypeOp>
    <arrayTypeOpEmpty>
        <val></val>
    </arrayTypeOpEmpty>
    <mapTypeOpEmpty>
        <val></val>
    </mapTypeOpEmpty>
    <arrayOpTypeOp>
        <val>$</val>
    </arrayOpTypeOp>
    <mapOpTypeOp>
        <val>$</val>
    </mapOpTypeOp>
</collection>
"""

