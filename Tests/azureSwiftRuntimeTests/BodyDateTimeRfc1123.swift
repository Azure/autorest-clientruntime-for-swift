//
//  BodyDate.swift
//  azureSwiftRuntimeTests
//
//  Created by Vladimir Shcherbakov on 12/27/17.
//

import Foundation
import XCTest
import azureSwiftRuntime

class BodyDateTimeRfc1123Tests: XCTestCase {
    
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
    
    func test_datetimerfc1123_getNull() {
        print("\n=================== #1 datetimerfc1123_getNull\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Datetimerfc1123.GetNullCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            XCTAssertNil(result)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_datetimerfc1123_getInvalid() {
        print("\n=================== #2 datetimerfc1123_getInvalid\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Datetimerfc1123.GetInvalidCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            // Tue, 01 Dec 2000 00:00:0A ABC"
            XCTAssertNil(result)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_datetimerfc1123_getOverflow() {
        print("\n=================== #3 datetimerfc1123_getOverflow\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Datetimerfc1123.GetOverflowCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            // "Sat, 1 Jan 10000 00:00:00 GMT"
            XCTAssertNil(result)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_datetimerfc1123_getUnderflow() {
        print("\n=================== #4 datetimerfc1123_getUnderflow\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Datetimerfc1123.GetUnderflowCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            // "Tue, 00 Jan 0000 00:00:00 GMT"
            XCTAssertNil(result)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_datetimerfc1123_putUtcMaxDateTime() {
        print("\n=================== #5 datetimerfc1123_putUtcMaxDateTime\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Datetimerfc1123.PutUtcMaxDateTimeCommand()
        cmd.datetimeBody = Date(fromString: "Fri, 31 Dec 9999 23:59:59 GMT", format: .dateTimeRfc1123)
        XCTAssertNotNil(cmd.datetimeBody)
        
        cmd.execute(client: self.azureClient) { (error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_datetimerfc1123_getUtcUppercaseMaxDateTime() {
        print("\n=================== #6 datetimerfc1123_getUtcUppercaseMaxDateTime\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Datetimerfc1123.GetUtcUppercaseMaxDateTimeCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            // "FRI, 31 DEC 9999 23:59:59 GMT"
            XCTAssertNotNil(result)
            let date = result!
            XCTAssertNotNil(date)
            
            let calendar = Calendar.current
            let components = calendar.dateComponents(in: TimeZone(identifier: "GMT")!, from: date)
            XCTAssertEqual(9999, components.year)
            XCTAssertEqual(12, components.month)
            XCTAssertEqual(31, components.day)
            XCTAssertEqual(23, components.hour)
            XCTAssertEqual(59, components.minute)
            XCTAssertEqual(59, components.second)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_datetimerfc1123_getUtcLowercaseMaxDateTime() {
        print("\n=================== #7 datetimerfc1123_getUtcLowercaseMaxDateTime\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Datetimerfc1123.GetUtcLowercaseMaxDateTimeCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            // "fri, 31 dec 9999 23:59:59 gmt"
            XCTAssertNotNil(result)
            let date = result!
            XCTAssertNotNil(date)
            
            let calendar = Calendar.current
            let components = calendar.dateComponents(in: TimeZone(identifier: "GMT")!, from: date)
            XCTAssertEqual(9999, components.year)
            XCTAssertEqual(12, components.month)
            XCTAssertEqual(31, components.day)
            XCTAssertEqual(23, components.hour)
            XCTAssertEqual(59, components.minute)
            XCTAssertEqual(59, components.second)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_datetimerfc1123_putUtcMinDateTime() {
        print("\n=================== #8 datetimerfc1123_putUtcMinDateTime\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Datetimerfc1123.PutUtcMinDateTimeCommand()
        cmd.datetimeBody = Date(fromString: "Mon, 1 Jan 0001 00:00:00 GMT", format: .dateTimeRfc1123)
        XCTAssertNotNil(cmd.datetimeBody)
        
        cmd.execute(client: self.azureClient) { (error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_datetimerfc1123_getUtcMinDateTime() {
        print("\n=================== #7 datetimerfc1123_getUtcMinDateTime\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Datetimerfc1123.GetUtcMinDateTimeCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            // "Mon, 01 Jan 0001 00:00:00 GMT"
            XCTAssertNotNil(result)
            let date = result!
            XCTAssertNotNil(date)
            
            let calendar = Calendar.current
            let components = calendar.dateComponents(in: TimeZone(identifier: "GMT")!, from: date)
            XCTAssertEqual(1, components.year)
            XCTAssertEqual(1, components.month)
            XCTAssertEqual(1, components.day)
            XCTAssertEqual(0, components.hour)
            XCTAssertEqual(0, components.minute)
            XCTAssertEqual(0, components.second)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
