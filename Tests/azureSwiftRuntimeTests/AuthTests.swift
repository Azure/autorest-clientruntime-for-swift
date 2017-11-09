//
//  AuthTests.swift
//  azureSwiftRuntimeTests
//
//  Created by Vladimir Shcherbakov on 10/27/17.
//

import XCTest
import RxBlocking
@testable import azureSwiftRuntime
@testable import RxSwift
@testable import Alamofire

class AuthTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testRuntimeClient() {
        do {
            let filepath = "/Users/vlashch/__sp/sp1.azureauth"
            let atc = try ApplicationTokenCredentials.fromFile(path: filepath)
            guard let defaultSubscription = atc.defaultSubscriptionId else {
                XCTFail("defaultSubscriptionId is nil")
                return
            }
            
            let storageAccountsListCommand = StorageAccountsListCommand(apiVersion: "2015-06-15", subscriptionId: defaultSubscription)
            let azureClient = AzureClient(atc: atc)
            guard let res = try azureClient.execute(command: storageAccountsListCommand) else {
                XCTFail("command result is nil")
                return
            }
            print(res)
            
        } catch RuntimeClientError.executionError(let message) {
            print("RuntimeClientError:", message)
            XCTFail(message)
        } catch {
            print("Error:", error)
            XCTFail()
        }
    }
    
    func testAuthData() {
        let loc = "/Users/vlashch/__sp/json.azureauth"
        let authData = AuthData.load(location: loc)
        XCTAssertNotNil(authData)
    }
    
    func testAuthFile() {
        let filepath = "/Users/vlashch/__sp/json.azureauth"
        XCTAssertNoThrow(try AuthFile.parseJsonFile(path: filepath))
    }
    
    func testAuthAdapter() {
        do {
            let filepath = "/Users/vlashch/__sp/json.azureauth"
            let applicationTokenCredentials = try ApplicationTokenCredentials.fromFile(path: filepath)
            let oauth2Handler = OAuth2Handler(azureTokenCredentials: applicationTokenCredentials)
            let sessionManager = SessionManager()
            sessionManager.adapter = oauth2Handler
            sessionManager.request("")
        } catch {
            print(error)
        }
    }
    
    func testApplicationClientCredentials() {
        let timeout: TimeInterval = 10.0
        let e = expectation(description: "Wait for HTTP request to compleate")
        let filepath = "/Users/vlashch/__sp/json.azureauth"
        do {
            let atc = try ApplicationTokenCredentials.fromFile(path: filepath)
            let value = try atc.authHeaderValue(url: nil)
            print("=== Header value: ", value)
            e.fulfill()
            
        } catch {
            print(error)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
        
    }
    
    func testAuth() {
        let loc = "/Users/vlashch/__sp/json.azureauth"
        guard let authData = AuthData.load(location: loc) else {
             return XCTFail("authData is nil")
        }
        
        let authObservable = AzureAuthticate(authData: authData).connect()
            

        guard let _ = try? authObservable.toBlocking().first() else {
            return
        }
    }
}
