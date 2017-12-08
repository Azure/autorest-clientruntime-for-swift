//
//  LongRunningOpsTest.swift
//  azureSwiftRuntimeTests
//
//  Created by Vladimir Shcherbakov on 11/16/17.
//

import XCTest
import RxSwift
//import Alamofire
@testable import azureSwiftRuntime

class LongRunningOpsTest: XCTestCase {
    
    let timeout: TimeInterval = 102.0
    var azureClient: AzureClient!
    
    var  product: ProductType!
    var sku: SkuType!

    override func setUp() {
        continueAfterFailure = false
        
        let env = AuzureEnvironment(endpoints:[
            .resourceManager : "http://localhost:3000"
        ])
        let atc = AzureTokenCredentials(environment: env, tenantId: "", subscriptionId: "")
        
        let customHeaders = ["x-ms-client-request-id":"9C4D50EE-2D56-4CD3-8152-34347DC9F2B0"]
        let responseHeadersToShow = ["Azure-AsyncOperation", "Location"]
        
        self.azureClient = AzureClient(atc: atc)
            .withRequestInterceptor(CustomHeadersInterseptor(customHeaders: customHeaders))
            .withRequestInterceptor(LogRequestInterceptor(showOptions: .all))
            .withResponseInterceptor(LogResponseInterceptor(showOptions: .all).withHeadersToShow(responseHeadersToShow))
        
        self.product = ProductType()
        self.product?.name = "TestProductName"
        self.product?.id = "TestProductId"
        self.product?.location = "West US"
        self.product?.type = "TestProductType"
        self.product?.properties = ProductPropertiesType()
        
        self.sku = SkuType()
        self.sku?.name = "Test sku name"
        self.sku?.id = "Test sku id"
        
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLROs_put200Succeeded() {
        print("\n=================== #1 LROs_put200Succeeded()\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPut200SucceededCommand()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
                XCTAssertNotNil(result)
                
                let product = result
                XCTAssertEqual("100", product?.id)
                XCTAssertEqual("foo", product?.name)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_put200SucceededNoState() {
        print("\n=================== #2 LROs_put200SucceededNoState()\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPut200SucceededNoStateCommand()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                
                XCTAssertNil(error)
                XCTAssertNotNil(result)
                
                let product = result
                XCTAssertEqual("100", product?.id)
                XCTAssertEqual("foo", product?.name)
                
                
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_put202Retry200() {
        print("\n=================== #3 LROs_put202Retry200()\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPut202Retry200Command()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                
                XCTAssertNil(error)
                XCTAssertNotNil(result)
                
                let product = result
                XCTAssertEqual("100", product?.id)
                XCTAssertEqual("foo", product?.name)
                
                
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_put201CreatingSucceeded200() {
        print("\n=================== #4 LROs_put201CreatingSucceeded200()\n")
        
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPut201CreatingSucceeded200Command()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
                XCTAssertNotNil(result)
                
                let product = result
                XCTAssertEqual("100", product?.id)
                XCTAssertEqual("foo", product?.name)
            }
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_put200UpdatingSucceeded204() {
        print("\n=================== #5 LROs_put200UpdatingSucceeded204()\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPut200UpdatingSucceeded204Command()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
                XCTAssertNotNil(result)
                
                let product = result
                XCTAssertEqual("100", product?.id)
                XCTAssertEqual("foo", product?.name)
            }
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_put201CreatingFailed200() {
        print("\n=================== #6 LROs_put201CreatingFailed200()\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPut201CreatingFailed200Command()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNotNil(error)
                XCTAssertNil(result)
            }
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_put200Acceptedcanceled200() {
        print("\n=================== #7 LROs_put200Acceptedcanceled200()\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPut200Acceptedcanceled200Command()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNotNil(error)
                XCTAssertNil(result)
            }
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    // #8
    func testLROs_putNoHeaderInRetry() {
        print("\n=================== #8 LROs_putNoHeaderInRetry()\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPutNoHeaderInRetryCommand()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
                XCTAssertNotNil(result)
                
                let product = result
                XCTAssertEqual("100", product?.id)
                XCTAssertEqual("foo", product?.name)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    //#9
    func testLROs_putAsyncRetrySucceeded() {
        print("\n=================== #9 LROs_putAsyncRetrySucceeded()\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        let cmd = LROsPutAsyncRetrySucceededCommand()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
                XCTAssertNotNil(result)
                
                let product = result
                XCTAssertEqual("100", product?.id)
                XCTAssertEqual("foo", product?.name)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    //#10
    func testLROs_putAsyncNoRetrySucceeded() {
        print("\n=================== #10 LROs_putAsyncNoRetrySucceeded()\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        let cmd = LROsPutAsyncNoRetrySucceededCommand()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
                XCTAssertNotNil(result)
                
                let product = result
                XCTAssertEqual("100", product?.id)
                XCTAssertEqual("foo", product?.name)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_putAsyncRetryFailed() {
        print("\n=================== #11 LROs_putAsyncRetryFailed()\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPutAsyncRetryFailedCommand()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNotNil(error)
                XCTAssertNil(result)
                
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.operationFailed {
                        // expected error
                    } catch {
                        XCTFail(error.localizedDescription)
                    }
                }
            }
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_putAsyncNoRetrycanceled() {
        print("\n=================== #12 LROs_putAsyncNoRetrycanceled()\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPutAsyncNoRetrycanceledCommand()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNotNil(error)
                XCTAssertNil(result)
                
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.operationCanceled {
                        // expected error
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                    }
                }
            }
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_putAsyncNoHeaderInRetry() {
        print("\n=================== #13 LROs_putAsyncNoHeaderInRetry()\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPutAsyncNoHeaderInRetryCommand()
        cmd.product = self.product
        
        do {            
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
                XCTAssertNotNil(result)
                
                let product = result
                XCTAssertEqual("100", product?.id)
                XCTAssertEqual("foo", product?.name)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_putNonResource() {
        print("\n=================== #14 LROs_putNonResource()\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPutNonResourceCommand()
        cmd.sku = self.sku
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
                
                XCTAssertNotNil(result)
                XCTAssertEqual("100", result?.id)
                XCTAssertEqual("sku", result?.name)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    // #15
    func testLROs_putAsyncNonResource() {
        print("\n=================== #15 LROs_putAsyncNonResource\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPutAsyncNonResourceCommand()
        cmd.sku = self.sku
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
                
                XCTAssertNotNil(result)
                XCTAssertEqual("100", result?.id)
                XCTAssertEqual("sku", result?.name)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_putSubResource() {
        print("\n=================== #16 LROs_putSubResource\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPutSubResourceCommand()
        
        cmd.product = SubProductType()
        cmd.product?.id = "Sub product id"
        cmd.product?.properties = SubProductPropertiesType()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
                
                XCTAssertNotNil(result)
                XCTAssertEqual("100", result?.id)
                //XCTAssertEqual("sub1", result?.subresource)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
   
    func testLROs_putAsyncSubResource() {
        print("\n=================== #17 LROs_putAsyncSubResource\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPutAsyncSubResourceCommand()
        
        cmd.product = SubProductType()
        cmd.product?.id = "Sub product id"
        cmd.product?.properties = SubProductPropertiesType()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
                
                XCTAssertNotNil(result)
                XCTAssertEqual("100", result?.id)
                //XCTAssertEqual("sub1", result?.subresource)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_deleteProvisioning202Accepted200Succeeded() {
        print("\n=================== #18 LROs_putSubResource\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsDeleteProvisioning202Accepted200SucceededCommand()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_deleteProvisioning202DeletingFailed200() {
        print("\n=================== #19 LROs_putSubResource\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsDeleteProvisioning202DeletingFailed200Command()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.operationFailed {
                        // expected error
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                    }
                }
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_deleteProvisioning202Deletingcanceled200() {
        print("\n=================== #20 LROs_putSubResource\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsDeleteProvisioning202Deletingcanceled200Command()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.operationCanceled {
                        // expected error
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                    }
                }
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_delete204Succeeded() {
        print("\n=================== #21 LROs_delete204Succeeded\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsDelete204SucceededCommand()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_delete202Retry200() {
        print("\n=================== #22 LROs_delete202Retry200\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsDelete202Retry200Command()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_delete202NoRetry204() {
        print("\n=================== #23 LROs_delete202NoRetry204\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsDelete202NoRetry204Command()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_deleteNoHeaderInRetry() {
        print("\n=================== #24 LROs_deleteNoHeaderInRetry\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsDeleteNoHeaderInRetryCommand()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_deleteAsyncNoHeaderInRetry() {
        print("\n=================== #25 LROs_deleteAsyncNoHeaderInRetry\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsDeleteAsyncNoHeaderInRetryCommand()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_deleteAsyncRetrySucceeded() {
        print("\n=================== #26 LROs_deleteAsyncRetrySucceeded\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsDeleteAsyncRetrySucceededCommand()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_deleteAsyncNoRetrySucceeded() {
        print("\n=================== #27 LROs_deleteAsyncNoRetrySucceeded\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsDeleteAsyncNoRetrySucceededCommand()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_deleteAsyncRetryFailed() {
        print("\n=================== #28 LROs_deleteAsyncRetryFailed\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsDeleteAsyncRetryFailedCommand()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.operationFailed {
                        // expected error
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                    }
                }
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_deleteAsyncRetrycanceled() {
        print("\n=================== #29 LROs_deleteAsyncRetrycanceled\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsDeleteAsyncRetrycanceledCommand()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.operationCanceled {
                        // expected error
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                    }
                }
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_post200WithPayload() {
        print("\n=================== #30 LROs_post200WithPayload\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPost200WithPayloadCommand()
        
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
            
// wrong returned data
// {"id":1, "name":"product"}
// typeMismatch(Swift.String, Swift.DecodingError.Context(codingPath: [azureSwiftRuntimeTests.SkuType.CodingKeys.id], debugDescription: "Expected to decode String but found a number instead.", underlyingError: nil))
                XCTAssertNil(error)
                XCTAssertNotNil(result)
                XCTAssertEqual("1", result?.id)
                XCTAssertEqual("product", result?.name)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_post202Retry200() {
        print("\n=================== #31 LROs_post202Retry200\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPost202Retry200Command()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
                XCTAssertNotNil(result)
                XCTAssertEqual("100", result?.id)
                XCTAssertEqual("foo", result?.name)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_post202NoRetry204() {
        print("\n=================== #32 LROs_post202NoRetry204\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPost202NoRetry204Command()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
                // FIXME: test-server doesn't return product - ask why
                // XCTAssertNotNil(result)
                // XCTAssertEqual("100", result?.id)
                // XCTAssertEqual("foo", result?.name)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_postAsyncRetrySucceeded() {
        print("\n=================== #33 LROs_postAsyncRetrySucceeded\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPostAsyncRetrySucceededCommand()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
                XCTAssertNotNil(result)
                XCTAssertEqual("100", result?.id)
                XCTAssertEqual("foo", result?.name)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_postAsyncNoRetrySucceeded() {
        print("\n=================== #34 LROs_postAsyncNoRetrySucceeded\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPostAsyncNoRetrySucceededCommand()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNil(error)
                XCTAssertNotNil(result)
                XCTAssertEqual("100", result?.id)
                XCTAssertEqual("foo", result?.name)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_postAsyncRetryFailed() {
        print("\n=================== #35 LROs_deleteAsyncRetrycanceled\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPostAsyncRetryFailedCommand()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNotNil(error)
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.operationFailed {
                        // FIXME: parse error details
                        // { "status": "Failed", "error": { "code": 500, "message": "Internal Server Error"}}
                        // expected error
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                    }
                }
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROs_postAsyncRetrycanceled() {
        print("\n=================== #36 LROs_postAsyncRetrycanceled\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROsPostAsyncRetrycanceledCommand()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNotNil(error)
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.operationCanceled {
                        // expected error
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                    }
                }
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLRORetrys_put201CreatingSucceeded200() {
        print("\n=================== #37 LRORetrys_put201CreatingSucceeded200\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LRORetrysPut201CreatingSucceeded200Command()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                //XCTAssertNotNil(error)
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.errorStatusCode(let code, _) {
                        XCTAssertEqual(500, code)
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                    }
                }
            }
            
        } catch {
            print("=== Error1:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROSADs_putNonRetry400() {
        print("\n=================== #44 LROSADs_putNonRetry400\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROSADsPutNonRetry400Command()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNotNil(error)
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.cloud(let cloudError) {
                        self.printCloudError(cloudError)
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                    }
                }
            }
            
        } catch {
            print("=== Error1:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    private func printCloudError(_ cloudError: CloudError) {
        var statusStr = ""
        if let status = cloudError.status {
            statusStr = "status: \(status), "
        }
        var messageStr = ""
        if let message = cloudError.message {
            messageStr = "message: \(message)"
        }
        print("=== Error:", "\(statusStr)\(messageStr)")
    }
    
    func testLROSADs_putNonRetry201Creating400() {
        print("\n=================== #45 LROSADs_putNonRetry201Creating400\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROSADsPutNonRetry201Creating400Command()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNotNil(error)
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.cloud(let cloudError) {
                        self.printCloudError(cloudError)
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                    }
                }
            }
            
        } catch {
            print("=== Error1:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROSADs_putNonRetry201Creating400InvalidJson() {
        print("\n=================== #46 LROSADs_putNonRetry201Creating400InvalidJson\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROSADsPutNonRetry201Creating400InvalidJsonCommand()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNotNil(error)
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.errorStatusCode(let code, let details) {
                        XCTAssertEqual(400, code)
                        XCTAssertEqual("<{ \"message\" : \"Error from the server\" }", details)
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                    }
                }
            }
            
        } catch {
            print("=== Error1:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROSADs_putAsyncRelativeRetry400() {
        print("\n=================== #47 LROSADs_putAsyncRelativeRetry400\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROSADsPutAsyncRelativeRetry400Command()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNotNil(error)
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.errorStatusCode(let code, let details) {
                        XCTAssertEqual(400, code)
                        XCTAssertEqual("no details", details)
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                    }
                }
            }
            
        } catch {
            print("=== Error1:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROSADs_deleteNonRetry400() {
        print("\n=================== #47 LROSADs_deleteNonRetry400\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROSADsDeleteNonRetry400Command()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                XCTAssertNotNil(error)
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.cloud(let cloudError) {
                        self.printCloudError(cloudError)
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                    }
                }
            }
            
        } catch {
            print("=== Error1:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROSADs_putError201NoProvisioningStatePayload() {
        print("\n=================== #54 LROSADs_putError201NoProvisioningStatePayload\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROSADsPutError201NoProvisioningStatePayloadCommand()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                // FIXME: don't know what to check here
                //XCTAssertNotNil(error)
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.cloud(let cloudError) {
                        self.printCloudError(cloudError)
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                    }
                }
            }
            
        } catch {
            print("=== Error1:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
   
    func testLROSADs_putAsyncRelativeRetryNoStatus() {
        print("\n=================== #55 LROSADs_putAsyncRelativeRetryNoStatus\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
//        <--  PUT http://localhost:3000/lro/error/putasync/retry/nostatus
//        --> 200 http://localhost:3000/lro/error/putasync/retry/nostatus
//        --> Location: http://localhost:3000/lro/error/putasync/retry/failed/operationResults/nostatus
//        --> Azure-AsyncOperation: http://localhost:3000/lro/error/putasync/retry/failed/operationResults/nostatus
//        --> { "properties": { "provisioningState": "Creating"}, "id": "100", "name": "foo" }
//        <--  GET http://localhost:3000/lro/error/putasync/retry/failed/operationResults/nostatus
//        --> 200 http://localhost:3000/lro/error/putasync/retry/failed/operationResults/nostatus
        // FIXME: Is the empty json an error?
//        --> { }
//        <--  GET http://localhost:3000/lro/error/putasync/retry/nostatus
//        --> 200 http://localhost:3000/lro/error/putasync/retry/nostatus
//        --> { }

        
        let cmd = LROSADsPutAsyncRelativeRetryNoStatusCommand()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                // FIXME: don't know what to check here
                //XCTAssertNotNil(error)
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.cloud(let cloudError) {
                        self.printCloudError(cloudError)
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                    }
                }
            }
            
        } catch {
            print("=== Error1:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROSADs_putAsyncRelativeRetryNoStatusPayload() {
        print("\n=================== #56 LROSADs_putAsyncRelativeRetryNoStatusPayload\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROSADsPutAsyncRelativeRetryNoStatusPayloadCommand()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                // FIXME: don't know what to check here
                //XCTAssertNotNil(error)
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.cloud(let cloudError) {
                        self.printCloudError(cloudError)
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                    }
                }
            }
            
        } catch {
            print("=== Error1:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROSADs_delete204Succeeded() {
        print("\n=================== #57 LROSADs_delete204Succeeded\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = LROSADsDelete204SucceededCommand()
        
//      <--  DELETE http://localhost:3000/lro/error/delete/204/nolocation
//      --> 204 http://localhost:3000/lro/error/delete/204/nolocation

        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                // FIXME: don't know what to check here
                //XCTAssertNotNil(error)
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.cloud(let cloudError) {
                        self.printCloudError(cloudError)
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                    }
                }
            }
            
        } catch {
            print("=== Error1:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROSADs_postAsyncRelativeRetryNoPayload() {
        print("\n=================== #60 LROSADs_postAsyncRelativeRetryNoPayload\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        let cmd = LROSADsPostAsyncRelativeRetryNoPayloadCommand()
        cmd.product = self.product
        
//      <-- POST http://localhost:3000/lro/error/postasync/retry/nopayload
//      <-- {"id":"TestProductId","properties":{},"type":"TestProductType","location":"West US","name":"TestProductName"}
//      -->     202 http://localhost:3000/lro/error/postasync/retry/nopayload
//      -->     Location: http://localhost:3000/lro/error/postasync/retry/failed/operationResults/nopayload
//      -->     Azure-AsyncOperation: http://localhost:3000/lro/error/postasync/retry/failed/operationResults/nopayload
//      <-- GET http://localhost:3000/lro/error/postasync/retry/failed/operationResults/nopayload
//      -->     200 http://localhost:3000/lro/error/postasync/retry/failed/operationResults/nopayload

        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                // FIXME: don't know what to check here
                //XCTAssertNotNil(error)
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.cloud(let cloudError) {
                        self.printCloudError(cloudError)
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                    }
                }
            }
            
        } catch {
            print("=== Error1:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
 
    func testLROSADs_put200InvalidJson() {
        print("\n=================== #61 LROSADs_put200InvalidJson\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        let cmd = LROSADsPut200InvalidJsonCommand()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                // FIXME: don't know what to check here
                //XCTAssertNotNil(error)
                if let curError = error {
                    do {
                        throw curError
                    } catch DecodingError.dataCorrupted(let context) {
                        print("=== Error context:", context)
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                        
                    }
                }
            }
            
        } catch {
            print("=== Error1:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROSADs_putAsyncRelativeRetryInvalidHeader() {
        print("\n=================== #62 LROSADs_putAsyncRelativeRetryInvalidHeader\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        let cmd = LROSADsPutAsyncRelativeRetryInvalidHeaderCommand()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                // FIXME: don't know what to check here
                //XCTAssertNotNil(error)
                if let curError = error {
                    do {
                        throw curError
                    } catch {
                        print("=== Error:", error)
                        
                    }
                }
            }
            
        } catch {
            print("=== Error1:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROSADs_putAsyncRelativeRetryInvalidJsonPolling() {
        print("\n=================== #63 LROSADs_putAsyncRelativeRetryInvalidJsonPolling\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        let cmd = LROSADsPutAsyncRelativeRetryInvalidJsonPollingCommand()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                // FIXME: don't know what to check here
                if let curError = error {
                    do {
                        throw curError
                    } catch DecodingError.dataCorrupted(let context) {
                        print("=== Error context:", context)
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                        
                    }
                }
            }
            
        } catch {
            print("=== Error1:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROsCustomHeader_putAsyncRetrySucceeded() {
        print("\n=================== #70 LROsCustomHeader_putAsyncRetrySucceeded\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        let cmd = LROsCustomHeaderPutAsyncRetrySucceededCommand()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                // FIXME: don't know what to check here
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.cloud(let cloudError) {
                        self.printCloudError(cloudError)
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                        
                    }
                }
            }
            
        } catch {
            print("=== Error1:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
 
    func testLROsCustomHeader_put201CreatingSucceeded200() {
        print("\n=================== #71 LROsCustomHeader_put201CreatingSucceeded200\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        let cmd = LROsCustomHeaderPut201CreatingSucceeded200Command()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                // FIXME: don't know what to check here
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.cloud(let cloudError) {
                        self.printCloudError(cloudError)
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                        
                    }
                }
            }
            
        } catch {
            print("=== Error1:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testLROsCustomHeader_post202Retry200() {
        print("\n=================== #72 LROsCustomHeader_post202Retry200\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        let cmd = LROsCustomHeaderPost202Retry200Command()
        cmd.product = self.product
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                // FIXME: don't know what to check here
                if let curError = error {
                    do {
                        throw curError
                    } catch RuntimeError.cloud(let cloudError) {
                        self.printCloudError(cloudError)
                    } catch {
                        print("=== Error:", error)
                        XCTFail("Unexpected error")
                        
                    }
                }
            }
            
        } catch {
            print("=== Error1:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testSwitcher() {
        let db = DisposeBag()
        
        let left = PublishSubject<String>()
        let right = PublishSubject<String>()
        
        let obs = left.amb(right)
        obs.subscribe(onNext: {value in
            print(value)
        }).disposed(by: db)
        
        left.onNext("left1")
        right.onNext("right1")
        left.onNext("left2")
        left.onNext("left3")
        right.onNext("right2")
    }
    
    
    func testFlatMap() {
        let db = DisposeBag()
        
        struct UrlVariable {
            var variable: Variable<Int>
        }
        
        let v1 = UrlVariable(variable: Variable(1))
        Observable<UrlVariable>.create { o -> Disposable in
                o.onNext(v1)
                return Disposables.create()
            }.flatMap { (v: UrlVariable) -> Observable<Int> in
                return v.variable.asObservable()
            }.subscribe(onNext: {
                    v in
                    print("Variable:", v)
            }).disposed(by: db)
        v1.variable.value = 30
        v1.variable.value = 60
    }
    
    func testFlatMap1() {
        struct Struct {
            var i: Int
            var s: String
            var b: Bool
        }
        
        let db = DisposeBag()
        
        struct StructWrap<T> {
            var wrapped: Variable<T>
        }
        
        //let obs = Observable.just("e")
        
        let v1 = StructWrap(wrapped: Variable(Struct(i: 1, s: "1", b: true)))
        
        Observable<StructWrap>.create { o -> Disposable in
            o.onNext(v1)
            return Disposables.create()
            }.flatMap { (sw: StructWrap) -> Observable<Struct> in
                return sw.wrapped.asObservable()
            }.subscribe(onNext: {
                v in
                print("Variable:", v)
                if v.b {
                    v1.wrapped.value = Struct(i: 10, s: "ten", b: false)
                    
                }
                
            }).disposed(by: db)
        
        v1.wrapped.value = Struct(i: 2, s: "2", b: true)
        v1.wrapped.value = Struct(i: 0, s: "0", b: false)
    }
    
    func testRetry() {
        let db = DisposeBag()
        
        enum TestError : Error {
            case error
        }
        
        var count = 1
        let obs = Observable<Int>.create { (o: AnyObserver<Int>) -> Disposable in
            o.onNext(1)
            o.onNext(2)
            
            if count == 1 {
                o.onError(TestError.error)
                count += 1
            }
            
            o.onNext(3)
            o.onNext(4)
            
            return Disposables.create()
        }.retry()
        
        
        obs.subscribe{
                print($0)
                
            }.addDisposableTo(db)
        
        
        
    }
    
    func testRetry1() {
        let db = DisposeBag()
        
        enum TestError : Error {
            case error
        }
        
        let obs = Observable<Int>.range(start: 1, count: 10)
            .mapWithIndex{ (val:Int, i: Int) -> Int in
                print("Map input[\(i)]=", val)
                if i == 3 {
                    throw TestError.error
                }
                return val
            }.retry(4)
        
        
        obs.subscribe{
            print($0)
            
            }.addDisposableTo(db)
        
        
        
    }
    
    func testFlatMapSubject() {
        
        let db = DisposeBag()
        
        
        
        struct UrlVariable {
            var variable: Variable<Int>
        }
        
        let v1 = UrlVariable(variable: Variable(1))
        let v2 = UrlVariable(variable: Variable(100))
        
        let subject = PublishSubject<UrlVariable>()
            
        subject.asObservable()
            .flatMap { (v: UrlVariable) -> Observable<Int> in
                return v.variable.asObservable()
            }.subscribe(onNext: {
                v in
                print("Variable:", v)
            }).disposed(by: db)
        
        subject.onNext(v1)
        
        v1.variable.value = 3
        
        subject.onNext(v2)
        
        v1.variable.value = 6
        
        v2.variable.value = 160
    }

//    func testRetryHandler() {
//        let e = expectation(description: "Wait for HTTP request to compleate")
//        let sessionManager = SessionManager()
//        sessionManager.retrier = LongRunningRequestAdapter()
//        //sessionManager.request("http://localhost:3000/lro/nonretryerror/put/400", method: .delete)
//        sessionManager.request("http://localhost:3000/lro/deleteasync/retry/succeeded", method: .delete)
//            .validate()
//            .response {
//                response in
//                
////                print("Request: \(response.request)")
////                print("Response: \(response.response)")
////                print("Error: \(response.error)")
//                
//                defer { e.fulfill() }
//        }
//        
//         waitForExpectations(timeout: timeout, handler: nil)
//        
//    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func getEnvironmentVar(name: String) -> String? {
        guard let rawValue = getenv(name) else { return nil }
        return String(utf8String: rawValue)
    }

}
