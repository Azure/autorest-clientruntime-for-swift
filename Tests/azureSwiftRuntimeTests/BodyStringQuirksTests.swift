/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 */

import Foundation
import XCTest
import azureSwiftRuntime

class BodyStringQuirksTests: XCTestCase {
    
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
    
    func test_string_getNull() {
        print("\n=================== #1.1 string_getNull\n")
        
        let cmd = StringNamespace.GetNullCommand()
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_string_putNull() {
        print("\n=================== #1.2 string_putNull\n")
        
        let cmd = StringNamespace.PutNullCommand()
        cmd.stringBody = nil
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    func test_string_getEmpty() {
        print("\n=================== #2.1 string_getEmpty\n")
        
        let cmd = StringNamespace.GetEmptyCommand()
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
            XCTAssertTrue(res!.isEmpty)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_string_putEmpty() {
        print("\n=================== #2.2 string_putEmpty\n")
        
        let cmd = StringNamespace.PutEmptyCommand()
        cmd.stringBody = ""
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_string_getMbcs() {
        print("\n=================== #3.1 string_getMbcs\n")
        
        let cmd = StringNamespace.GetMbcsCommand()
        //cmd.resourceArray = [self.resource1, self.resource2]
        do {
            if let mbs = try cmd.execute(client: self.azureClient) {
                XCTAssertEqual("啊齄丂狛狜隣郎隣兀﨩ˊ〞〡￤℡㈱‐ー﹡﹢﹫、〓ⅰⅹ⒈€㈠㈩ⅠⅫ！￣ぁんァヶΑ︴АЯаяāɡㄅㄩ─╋︵﹄︻︱︳︴ⅰⅹɑɡ〇〾⿻⺁䜣€", mbs)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_string_putMbcs() {
        print("\n=================== #3.2 string_putMbcs\n")
        
        let cmd = StringNamespace.PutMbcsCommand()
        cmd.stringBody = "啊齄丂狛狜隣郎隣兀﨩ˊ〞〡￤℡㈱‐ー﹡﹢﹫、〓ⅰⅹ⒈€㈠㈩ⅠⅫ！￣ぁんァヶΑ︴АЯаяāɡㄅㄩ─╋︵﹄︻︱︳︴ⅰⅹɑɡ〇〾⿻⺁䜣€"
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_string_getWhitespace() {
        print("\n=================== #4.1 string_getWhitespace\n")
        
        let cmd = StringNamespace.GetWhitespaceCommand()
        
        do {
            try cmd.executeAsync(client: self.azureClient){
                res, error in
                do {
                    if let e = error {
                        throw e
                    }
                    XCTAssertNotNil(res)
                    XCTAssertEqual(res!, "    Now is the time for all good men to come to the aid of their country    ")
                    
                } catch {
                    print("=== Error:", error)
                    XCTFail(error.localizedDescription)
                }
                
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        
//        do {
//            let res = try cmd.execute(client: self.azureClient)
//            XCTAssertNotNil(res)
//            XCTAssertEqual(res!, "    Now is the time for all good men to come to the aid of their country    ")
//        } catch {
//            print("=== Error:", error)
//            XCTFail(error.localizedDescription)
//        }
    }
    
    func test_string_putWhitespace() {
        print("\n=================== #4.2 string_putWhitespace\n")
        
        let cmd = StringNamespace.PutWhitespaceCommand()
        cmd.stringBody = "    Now is the time for all good men to come to the aid of their country    "
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_enum_getNotExpandable() {
        print("\n=================== #5.1 enum_getNotExpandable\n")
        
        let cmd = EnumNamespace.GetNotExpandableCommand()
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
            XCTAssertEqual(Colors.Redcolor, res)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_enum_putNotExpandable() {
        print("\n=================== #5.2 enum_putNotExpandable\n")
        
        let cmd = EnumNamespace.PutNotExpandableCommand()
        cmd.stringBody = Colors.Redcolor
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_enum_getReferenced() {
        print("\n=================== #6.1 enum_getReferenced\n")
        
        let cmd = EnumNamespace.GetReferencedCommand()
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
            XCTAssertEqual(Colors.Redcolor, res)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_enum_putReferenced() {
        print("\n=================== #6.2 enum_putReferenced\n")
        
        let cmd = EnumNamespace.PutReferencedCommand()
        cmd.enumStringBody = Colors.Redcolor
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_enum_getReferencedConstant() {
        print("\n=================== #7.1 enum_getReferencedConstant\n")
        
        let cmd = EnumNamespace.GetReferencedConstantCommand()
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
            XCTAssertEqual("Sample String", res?.field1)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_enum_putReferencedConstant() {
        print("\n=================== #7.2 enum_putReferencedConstant\n")
        
        let cmd = EnumNamespace.PutReferencedConstantCommand()
        cmd.enumStringBody = RefColorConstantData()
        
        // FiXME: colorConstant should be enum with the only case "green-color"
        cmd.enumStringBody?.colorConstant = "green-color"
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_string_getNotProvided() {
        print("\n=================== #8 string_getNotProvided\n")
        
        let cmd = StringNamespace.GetNotProvidedCommand()
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_string_getBase64Encoded() {
        print("\n=================== #9 string_getBase64Encoded\n")
        
        let cmd = StringNamespace.GetBase64EncodedCommand()
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
            XCTAssertEqual("a string that gets encoded with base64", res!.base64Decoded())
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_string_getBase64UrlEncoded() {
        print("\n=================== #10.1 string_getBase64UrlEncoded\n")
        
        let cmd = StringNamespace.GetBase64UrlEncodedCommand()
        //cmd.resourceArray = [self.resource1, self.resource2]
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNotNil(res)
            XCTAssertEqual("a string that gets encoded with base64url", res!.base64uriDecoded())
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_string_putBase64UrlEncoded() {
        print("\n=================== #10.2 string_putBase64UrlEncoded\n")
        
        let cmd = StringNamespace.PutBase64UrlEncodedCommand()
        cmd.stringBody = "a string that gets encoded with base64url".base64uriEncoded()
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_string_getNullBase64UrlEncoded() {
        print("\n=================== #11 string_getNullBase64UrlEncoded\n")
        
        let cmd = StringNamespace.GetNullBase64UrlEncodedCommand()
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
}
