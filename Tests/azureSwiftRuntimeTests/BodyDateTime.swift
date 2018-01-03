//
//  BodyDate.swift
//  azureSwiftRuntimeTests
//
//  Created by Vladimir Shcherbakov on 12/27/17.
//

import Foundation
import XCTest
import azureSwiftRuntime

class BodyDateTimeTests: XCTestCase {
    
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
    
    func test_datetime_getNull() {
        print("\n=================== #1 datetime_getNull\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Datetime.GetNullCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            XCTAssertNil(result)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_datetime_getInvalid() {
        print("\n=================== #2 datetime_getInvalid\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Datetime.GetInvalidCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            // "201O-18-90D00:89:56.999AAAAX"
            XCTAssertNil(result)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_datetime_getOverflow() {
        print("\n=================== #3 datetime_getOverflow\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Datetime.GetOverflowCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            // "9999-12-31T23:59:59.9999999-14:00"
            XCTAssertNil(result)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_datetime_getUnderflow() {
        print("\n=================== #4 datetime_getUnderflow\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Datetime.GetUnderflowCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            // "0000-00-00T00:00:00.0000000+00:00"
            XCTAssertNil(result)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_datetime_putUtcMaxDateTime() {
        print("\n=================== #4 datetime_putUtcMaxDateTime\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Datetime.PutUtcMaxDateTimeCommand()
        cmd.datetimeBody = Date(fromString: "9999-12-31T23:59:59.9999999Z", format: AzureDate.dateTime.toFormatString())
        
        cmd.execute(client: self.azureClient) { (error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_datetime_getUtcLowercaseMaxDateTime() {
        print("\n=================== #4 datetime_getUtcLowercaseMaxDateTime\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Datetime.GetUtcLowercaseMaxDateTimeCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            // "9999-12-31t23:59:59.9999999z"
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
    
    func test_datetime_getUtcUppercaseMaxDateTime() {
        print("\n=================== #4 datetime_getUtcUppercaseMaxDateTime\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Datetime.GetUtcUppercaseMaxDateTimeCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            // "9999-12-31T23:59:59.9999999Z"
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
    
    func test_datetime_putUtcMinDateTime() {
        print("\n=================== #4 datetime_putUtcMinDateTime\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Datetime.PutUtcMinDateTimeCommand()
        cmd.datetimeBody = Date(fromString: "0001-01-01T00:00:00.0Z", format: AzureDate.dateTime.toFormatString())
        XCTAssertNotNil(cmd.datetimeBody)
        
        cmd.execute(client: self.azureClient) { (error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func test_datetime_getUtcMinDateTime() {
        print("\n=================== #4 datetime_getUtcMinDateTime\n")
        
        let e = expectation(description: "Wait for HTTP request to complete")
        
        let cmd = Datetime.GetUtcMinDateTimeCommand()
        
        cmd.execute(client: self.azureClient) { (result, error) in
            defer { e.fulfill() }
            XCTAssertNil(error)
            // 0001-01-01T00:00:00Z"
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
