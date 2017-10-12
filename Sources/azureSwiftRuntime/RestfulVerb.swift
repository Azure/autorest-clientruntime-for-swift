//
//  RestfulVerb.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Alva D Bandy on 10/4/17.
//

public enum RestfulVerb {
    case Get(url: String)
    case Put (url: String, data: [String: Any])
    case Post (url: String, data: [String: Any])
    case Patch (url: String, data: [String: Any])
    case Delete (url: String)
}
