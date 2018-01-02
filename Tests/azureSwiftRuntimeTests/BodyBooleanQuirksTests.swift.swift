/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 */

import Foundation
import XCTest
import azureSwiftRuntime

class BodyBooleanQuirksTests: XCTestCase {
    
    let timeout: TimeInterval = 102.0
    var azureClient: AzureClient!
    
    override func setUp() {
        continueAfterFailure = false
        
        let env = AuzureEnvironment(endpoints:[
            .resourceManager : "http://localhost:3000"
            ])
        
        let atc = AzureTokenCredentials(environment: env, tenantId: "", subscriptionId: "")
        
        self.azureClient = AzureClient(atc: atc)
            .withRequestInterceptor(LogRequestInterceptor(showOptions: .all))
            .withResponseInterceptor(LogResponseInterceptor(showOptions: .all))
        
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_bool_putTrue() {
        print("\n=================== #1.1 bool_getTrue\n")
        
        let cmd = BoolNamespace.PutTrueCommand()
        cmd.boolBody = true
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
    
    func test_bool_getTrue() {
        print("\n=================== #1.2 bool_putTrue\n")
        
        let cmd = BoolNamespace.GetTrueCommand()
        let expectedResult = true
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
            XCTAssertEqual(expectedResult, res!)
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
    
    func test_bool_putFalse() {
        print("\n=================== #2.1 bool_putFalse\n")
        
        let cmd = BoolNamespace.PutFalseCommand()
        cmd.boolBody = false
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
    
    func test_bool_getFalse() {
        print("\n=================== #2.2 bool_getFalse\n")
        
        let cmd = BoolNamespace.GetFalseCommand()
        let expectedResult = false
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
            XCTAssertEqual(expectedResult, res!)
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
    
    func test_bool_getNull() {
        print("\n=================== #3 bool_getNull\n")
        
        let cmd = BoolNamespace.GetNullCommand()
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_bool_getInvalid() {
        print("\n=================== #4 bool_getInvalid\n")
        
        let cmd = BoolNamespace.GetInvalidCommand()
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            print("=== Error:", error)
            if (error as NSError).code != 3840 {
                XCTFail(error.localizedDescription)
            }
        }
    }
}
