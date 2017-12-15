//
//  BodyFileTests.swift
//  azureSwiftRuntimeTests
//
//  Created by Vladimir Shcherbakov on 12/13/17.
//

import Foundation
import XCTest
import azureSwiftRuntime

class BodyFileTests: XCTestCase {
    
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
    
    func test_files_GetFile() {
        print("\n=================== #1 files_GetFile\n")
        
        let cmd = FilesNamespace.GetFileCommand()
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
            XCTAssertEqual(8725, res!.count)
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
    
    func test_files_GetFileLarge() {
        print("\n=================== #2 files_GetFileLarge\n")
        
        let cmd = FilesNamespace.GetFileLargeCommand()
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
            XCTAssertEqual(3145728000, res!.count)
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
    
    func test_files_GetEmptyFile() {
        print("\n=================== #3 files_GetEmptyFile\n")
        
        let cmd = FilesNamespace.GetEmptyFileCommand()
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
            XCTAssertEqual(0, res!.count)
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
}

