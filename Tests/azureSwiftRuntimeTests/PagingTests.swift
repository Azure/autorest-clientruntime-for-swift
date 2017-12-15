//
//  PagingTests.swift
//  azureSwiftRuntime
//
//  Created by Vladimir Shcherbakov on 12/14/17.
//

import Foundation
import XCTest
import azureSwiftRuntime

class PagingTests: XCTestCase {
    
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
    
    func checkResult(_ res: ProductResultProtocol?) {
        XCTAssertNotNil(res)
        guard let values = res?.values else {
            XCTFail()
            return
        }
        
        for value in values {
            let properties = value?.properties
            XCTAssertNotNil(properties?.id)
            XCTAssertNotNil(properties?.name)
        }
    }
    
    func checkResult(_ res: OdataProductResultProtocol?) {
        XCTAssertNotNil(res)
        guard let values = res?.values else {
            XCTFail()
            return
        }
        
        for value in values {
            let properties = value?.properties
            XCTAssertNotNil(properties?.id)
            XCTAssertNotNil(properties?.name)
        }
    }
    
    func test_Paging_getSinglePages() {
        print("\n=================== #1 Paging_getSinglePages\n")
        
        let cmd = PagingNamespace.GetSinglePagesCommand()
        
        do {
            var res = try cmd.getFirstPage(client: self.azureClient)
            checkResult(res)
            
            while let next = try cmd.getNextPage(from: res, client: self.azureClient) {
                checkResult(next)
                res = next
            }
            
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
    
    func test_Paging_getMultiplePages() {
        print("\n=================== #2 Paging_getMultiplePages\n")
        
        let cmd = PagingNamespace.GetMultiplePagesCommand()
        
        do {
            var res = try cmd.getFirstPage(client: self.azureClient)
            checkResult(res)
            
            while let next = try cmd.getNextPage(from: res, client: self.azureClient) {
                checkResult(next)
                res = next
            }
            
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
    
    func test_Paging_getOdataMultiplePages() {
        print("\n=================== #3 Paging_getOdataMultiplePages\n")
        
        let cmd = PagingNamespace.GetOdataMultiplePagesCommand()
        
        do {
            var res = try cmd.getFirstPage(client: self.azureClient)
            checkResult(res)
            
            while let next = try cmd.getNextPage(from: res, client: self.azureClient) {
                checkResult(next)
                res = next
            }
            
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
    
    func test_Paging_getMultiplePagesWithOffset() {
        print("\n=================== #4 Paging_getMultiplePagesWithOffset\n")
        
        let cmd = PagingNamespace.GetMultiplePagesWithOffsetCommand()
        // FIXME: should it be mandatory on has default value
        cmd.offset = 1
        
        do {
            var res = try cmd.getFirstPage(client: self.azureClient)
            checkResult(res)
            
            while let next = try cmd.getNextPage(from: res, client: self.azureClient) {
                checkResult(next)
                res = next
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_Paging_getMultiplePagesRetryFirst() {
        print("\n=================== #5 Paging_getMultiplePagesRetryFirst\n")
        
        let cmd = PagingNamespace.GetMultiplePagesRetryFirstCommand()
        
        do {
            var res = try cmd.getFirstPage(client: self.azureClient)
            checkResult(res)
            
            while let next = try cmd.getNextPage(from: res, client: self.azureClient) {
                checkResult(next)
                res = next
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_Paging_getMultiplePagesRetrySecond() {
        print("\n=================== #6 Paging_getMultiplePagesRetrySecond\n")
        
        let cmd = PagingNamespace.GetMultiplePagesRetrySecondCommand()
        
        do {
            var res = try cmd.getFirstPage(client: self.azureClient)
            checkResult(res)
            
            while let next = try cmd.getNextPage(from: res, client: self.azureClient) {
                checkResult(next)
                res = next
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_Paging_getSinglePagesFailure() {
        print("\n=================== #7 Paging_getSinglePagesFailure\n")
        
        let cmd = PagingNamespace.GetSinglePagesFailureCommand()
        
        do {
            var res = try cmd.getFirstPage(client: self.azureClient)
            checkResult(res)
            
            while let next = try cmd.getNextPage(from: res, client: self.azureClient) {
                checkResult(next)
                res = next
            }
            
        } catch RuntimeError.cloud(let error){
            let status = error.status
            let message = error.message
            XCTAssertEqual(status, 400)
            XCTAssertEqual(message, "Expected single failure test.")
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_Paging_getMultiplePagesFailure() {
        print("\n=================== #7 Paging_getMultiplePagesFailure\n")
        
        let cmd = PagingNamespace.GetMultiplePagesFailureCommand()
        
        do {
            var res = try cmd.getFirstPage(client: self.azureClient)
            checkResult(res)
            
            while let next = try cmd.getNextPage(from: res, client: self.azureClient) {
                checkResult(next)
                res = next
            }
            
        } catch RuntimeError.cloud(let error){
            print("=== Error:", error)
            let status = error.status
            let message = error.message
            XCTAssertEqual(status, 400)
            XCTAssertEqual(message, "Expected single failure test.")
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_Paging_getMultiplePagesFailureUri() {
        print("\n=================== #7 Paging_getMultiplePagesFailureUri\n")
        
        let cmd = PagingNamespace.GetMultiplePagesFailureUriCommand()
        
        do {
            var res = try cmd.getFirstPage(client: self.azureClient)
            checkResult(res)
            
            while let next = try cmd.getNextPage(from: res, client: self.azureClient) {
                checkResult(next)
                res = next
            }
            
        } catch {
            print("=== Error:", error)
            let e = error as NSError
            XCTAssertNotNil(e.userInfo["NSErrorFailingURLStringKey"])
            XCTAssertNotNil(e.userInfo["NSErrorFailingURLKey"])
        }
    }
    
    func test_Paging_getMultiplePagesFragmentNextLink() {
        print("\n=================== #7 Paging_getMultiplePagesFragmentNextLink\n")
        
        let cmd = PagingNamespace.GetMultiplePagesFragmentNextLinkCommand()
        // TODO: the test-server waits for these specific values, but thay are not specified in the swagger
        cmd.tenant = "test_user"
        cmd.apiVersion="1.6"
        // TODO: the test-server waits for the 'api_version' (with underscore) query param (should be 'api-version' (with dash))
        
        do {
            var res = try cmd.getFirstPage(client: self.azureClient)
            checkResult(res)
            
            while let next = try cmd.getNextPage(from: res, client: self.azureClient) {
                checkResult(next)
                res = next
            }
            
        } catch {
            print("=== Error:", error)
            let e = error as NSError
            XCTAssertNotNil(e.userInfo["NSErrorFailingURLStringKey"])
            XCTAssertNotNil(e.userInfo["NSErrorFailingURLKey"])
        }
    }
    
    func test_Paging_getMultiplePagesFragmentWithGroupingNextLink() {
        print("\n=================== #8 Paging_getMultiplePagesFragmentWithGroupingNextLink\n")
        
        let cmd = PagingNamespace.GetMultiplePagesFragmentWithGroupingNextLinkCommand()
        cmd.tenant = "test_user"
        cmd.apiVersion="1.6"
        
        do {
            var res = try cmd.getFirstPage(client: self.azureClient)
            checkResult(res)
            
            while let next = try cmd.getNextPage(from: res, client: self.azureClient) {
                checkResult(next)
                res = next
            }
            
        } catch {
            print("=== Error:", error)
            let e = error as NSError
            XCTAssertNotNil(e.userInfo["NSErrorFailingURLStringKey"])
            XCTAssertNotNil(e.userInfo["NSErrorFailingURLKey"])
        }
    }
}
