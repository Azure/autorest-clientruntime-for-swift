//
//  JustArrayXML.swift
//  azureSwiftRuntime
//
//  Created by Vladimir Shcherbakov on 1/26/18.
//

import Foundation
import XCTest
import azureSwiftRuntime


class TopLevelXMLTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTopLevelArray() {
        do {
            let res = try XMLDecoder().decode([Int?]?.self, from: xmlTopLevelArray.data(using: .utf8)!)
            if let array = res {
                for val in array {
                    print (val ?? "-")
                }
            } else {
                print("Array is empty")
            }
            
        } catch {
            print ("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func testTopLevelArrayOfBooks() {
        do {
            let res = try XMLDecoder().decode([Book?]?.self, from: xmlTopLevelArrayOfBooks.data(using: .utf8)!)
            if let books = res {
                for book in books {
                    print ("id: ", book?.id ?? "-")
                    print ("name: ", book?.name ?? "-")
                }
            } else {
                print("Array is empty")
            }
            
        } catch {
            print ("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
}
