//
//  RestfulError.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Alva D Bandy on 10/7/17.
//

class RestfulError : Error {
    var description: String
    
    init(_ description: String) {
        self.description = description
    }
}
