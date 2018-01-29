//
//  TopLevelArrayXML.swift
//  azureSwiftRuntime
//
//  Created by Vladimir Shcherbakov on 1/26/18.
//

import Foundation

let xmlTopLevelArray =
"""
<Array>
    <val>1</val>
    <val>2</val>
    <val>3</val>
    <val></val>
    <val>5</val>
</Array>
"""

struct Book : Decodable {
    let name: String?
    let id: Int?
}

let xmlTopLevelArrayOfBooks =
"""
<Books>
    <Book>
        <name>One</name>
        <id>1</id>
    </Book>
    <Book>
        <name>Two</name>
        <id>2</id>
    </Book>
    <Book>
        <name>Three</name>
        <id>3</id>
    </Book>
    <Book>
        <name>Four</name>
        <id></id>
    </Book>
    <Book/>
</Books>
"""
