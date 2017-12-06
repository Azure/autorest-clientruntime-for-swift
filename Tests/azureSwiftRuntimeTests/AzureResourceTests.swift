//
//  azureTests.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Vladimir Shcherbakov on 12/3/17.
//

import Foundation


import XCTest
@testable import azureSwiftRuntime

class AzureTests: XCTestCase {

    let timeout: TimeInterval = 102.0
    var azureClient: AzureClient!
    
    var  resource1: ResourceProtocol?
    var  resource2: ResourceProtocol?
    
    override func setUp() {
        continueAfterFailure = false
        
        let env = AuzureEnvironment(endpoints:[
            .resourceManager : "http://localhost:3000"
            ])
        
        let atc = AzureTokenCredentials(environment: env, tenantId: "", subscriptionId: "")
        
        let customHeaders = ["x-ms-client-request-id":"9C4D50EE-2D56-4CD3-8152-34347DC9F2B0"]
        
        self.azureClient = AzureClient(atc: atc)
            .withRequestInterceptor(CustomHeadersInterseptor(customHeaders: customHeaders))
            .withRequestInterceptor(LogRequestInterceptor(showOptions: .all))
            .withResponseInterceptor(LogResponseInterceptor(showOptions: .all))
        
        self.resource1 = ResourceData()
        self.resource1?.id = "res1"
        self.resource1?.name = "res#1"
        self.resource1?.location = "West US1"
        self.resource1?.type = "type #1"
        
        self.resource2 = ResourceData()
        self.resource2?.id = "res2"
        self.resource2?.name = "res#2"
        self.resource2?.location = "West US2"
        self.resource2?.type = "type #2"
        
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
// === azure-resource.json
    
    func test_putArray() {
        print("\n=================== #1 putArray()\n")
        
        let cmd = AzureResource.PutArrayCommand()
        cmd.resourceArray = [self.resource1, self.resource2]
        
        do {
            _ = try cmd.execute(client: self.azureClient)
            
        } catch {
            print("=== Error:", error)
            // Not implemented
            //XCTFail(error.localizedDescription)
        }
    }

}
