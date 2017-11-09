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
    let filepath = ""
    
    func testAuthData() {
        let authData = AuthData.load(location: filepath)
        XCTAssertNotNil(authData)
    }
    
    func testAuthFile() {
        XCTAssertNoThrow(try AuthFile.parseJsonFile(path: filepath))
    }
    
    func testAuthAdapter() {
        do {
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
        guard let authData = AuthData.load(location: filepath) else {
             return XCTFail("authData is nil")
        }
        
        let authObservable = AzureAuthticate(authData: authData).connect()
            

        guard let _ = try? authObservable.toBlocking().first() else {
            return
        }
    }
}
