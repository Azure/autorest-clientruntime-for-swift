//
//  BodyAsNumberQuirks.swift
//  azureSwiftRuntimeTests
//
//  Created by Vladimir Shcherbakov on 12/11/17.
//

import Foundation
import XCTest
import azureSwiftRuntime

class BodyNumberQuirksTests: XCTestCase {
    
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
    
    func test_number_getNull() {
        print("\n=================== #1 number_getNull\n")
        
        let cmd = NumberNamespace.GetNullCommand()
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_number_getInvalidFloat() {
        print("\n=================== #2 number_getInvalidFloat\n")
        
        let cmd = NumberNamespace.GetInvalidFloatCommand()
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
        } catch {
            if (error as NSError).code != 3840 {
                XCTFail(error.localizedDescription)
            }
            
            print("=== Error:", error)
        }
    }
    
    func test_number_getInvalidDouble() {
        print("\n=================== #3 number_getInvalidDouble\n")
        
        let cmd = NumberNamespace.GetInvalidDoubleCommand()
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
        } catch {
            if (error as NSError).code != 3840 {
                XCTFail(error.localizedDescription)
            }
            
            print("=== Error:", error)
        }
    }
    
    func test_number_putBigFloat() {
        print("\n=================== #4.1 number_putBigFloat\n")
        
        let cmd = NumberNamespace.PutBigFloatCommand()
        cmd.numberBody = 3.402823e+20
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
    
    func test_number_getBigFloat() {
        print("\n=================== #4.2 number_getBigFloat\n")
        
        let cmd = NumberNamespace.GetBigFloatCommand()
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
            XCTAssertEqual(3.402823e+20, res)
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
    
    func test_number_putBigDouble() {
        print("\n=================== #5.1 number_putBigDouble\n")
        
        let cmd = NumberNamespace.PutBigDoubleCommand()
        cmd.numberBody = 2.5976931e+101
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
    
    func test_number_getBigDouble() {
        print("\n=================== #5.2 number_getBigDouble\n")
        
        let cmd = NumberNamespace.GetBigDoubleCommand()
        let number: Double = 2.5976931e+101
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
            XCTAssertEqual(number/1e+101, res!/1e+101)
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
    
    func test_number_putBigDoubleNegativeDecimal() {
        print("\n=================== #5.1 number_putBigDoubleNegativeDecimal\n")
        
        let cmd = NumberNamespace.PutBigDoubleNegativeDecimalCommand()
        cmd.numberBody = -99999999.99
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
    
    func test_number_getBigDoubleNegativeDecimal() {
        print("\n=================== #5.2 number_getBigDoubleNegativeDecimal\n")
        
        let cmd = NumberNamespace.GetBigDoubleNegativeDecimalCommand()
        let number: Double = -99999999.99
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
            XCTAssertEqual(number, res!)
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
/*
    func test_number_putBigDecimal() {
        print("\n=================== #6.1 number_putBigDecimal\n")
        
        let cmd = NumberNamespace.PutBigDecimalCommand()
        cmd.numberBody = 2.5976931e+101
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_number_getBigDecimal() {
        print("\n=================== #6.2 number_getBigDecimal\n")
        
        let cmd = NumberNamespace.GetBigDecimalCommand()
        let number: Decimal = 2.5976931e+101
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
            //XCTAssertEqual(number/1e+101, res!/1e+101, accuracy: Decimal(10.0))
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
*/
    func test_number_putSmallFloat() {
        print("\n=================== #7.1 number_putSmallFloat\n")
        
        let cmd = NumberNamespace.PutSmallFloatCommand()
        cmd.numberBody = 3.402823e-20
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
    
    func test_number_getSmallFloat() {
        print("\n=================== #7.2 number_getSmallFloat\n")
        
        let cmd = NumberNamespace.GetSmallFloatCommand()
        let number: Float = 3.402823e-20
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
            XCTAssertEqual(number, res!)
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
    
    func test_number_putSmallDouble() {
        print("\n=================== #8.1 number_putSmallDouble\n")
        
        let cmd = NumberNamespace.PutSmallDoubleCommand()
        cmd.numberBody = 2.5976931e-101
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
    
    func test_number_getSmallDouble() {
        print("\n=================== #8.2 number_getSmallDouble\n")
        
        let cmd = NumberNamespace.GetSmallDoubleCommand()
        let number: Double = 2.5976931e-101
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
            XCTAssertEqual(number/1e+101, res!/1e+101, accuracy: 4.53255549978056e-218)
        } catch {
            XCTFail(error.localizedDescription)
            print("=== Error:", error)
        }
    }
}

