//
//  Restful.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Alva D Bandy on 10/4/17.
//
import SwiftyJSON
import RxSwift

public protocol Restful {
    func call() -> Observable<JSON?>
}

