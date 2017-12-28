//
//  BodyDate.swift
//  azureSwiftRuntimeTests
//
//  Created by Vladimir Shcherbakov on 12/27/17.
//

import Foundation
import XCTest
import azureSwiftRuntime

class BodyDateTests: XCTestCase {
    
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
    
    func test_date_getNull() {
        print("\n=================== #1 date_getNull\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = DateNamespace.GetNullCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            XCTAssertNil(result)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_date_getInvalidDate() {
        print("\n=================== #2 date_getInvalidDate\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = DateNamespace.GetInvalidDateCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            XCTAssertNotNil(result)
            
            // TODO: check date is valid
            print("=== Result", result!)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_date_getOverflowDate() {
        print("\n=================== #3 date_getOverflowDate\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = DateNamespace.GetOverflowDateCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            XCTAssertNotNil(result)
            
            // TODO: check date is valid
            print("=== Result", result!)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_date_getUnderflowDate() {
        print("\n=================== #4 date_getUnderflowDate\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = DateNamespace.GetUnderflowDateCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            XCTAssertNotNil(result)
            
            // TODO: check date is valid
            print("=== Result", result!)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_date_putMaxDate() {
        print("\n=================== #4 date_putMaxDate\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = DateNamespace.PutMaxDateCommand()
        cmd.dateBody = "9999-12-31"
        
        cmd.execute(client: self.azureClient) { (error) in
            defer { e.fulfill() }
            //XCTAssertNil(error)
            //print("=== Error",error!)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_date_getMaxDate() {
        print("\n=================== #4 date_getMaxDate\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = DateNamespace.GetMaxDateCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            XCTAssertNotNil(result)
            
            // TODO: check date is valid
            print("=== Result", result!)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_date_putMinDate() {
        print("\n=================== #4 date_putMinDate\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = DateNamespace.PutMinDateCommand()
        cmd.dateBody = "0000-01-01"
        
        cmd.execute(client: self.azureClient) { (error) in
            defer { e.fulfill() }
            //XCTAssertNil(error)
            //print("=== Error",error!)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_date_getMinDate() {
        print("\n=================== #4 date_getMinDate\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = DateNamespace.GetMinDateCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            XCTAssertNotNil(result)
            
            // TODO: check date is valid
            print("=== Result", result!)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
