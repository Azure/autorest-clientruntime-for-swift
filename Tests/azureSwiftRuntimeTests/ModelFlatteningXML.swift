/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 */

import Foundation
import XCTest
import azureSwiftRuntime

class ModelFlatteningTestsXML: XCTestCase {
    
    let timeout: TimeInterval = 102.0
    var azureClient: AzureClient!
    
    var flattenedProduct1: FlattenedProductProtocol?
    var flattenedProduct2: FlattenedProductProtocol?
    var flattenedProduct3: FlattenedProductProtocol?
    
    var resource1: ResourceProtocol?
    var resource2: ResourceProtocol?
    
    var flattenedProduct4: FlattenedProductProtocol?
    var flattenedProduct5: FlattenedProductProtocol?
    
    override func setUp() {
        continueAfterFailure = false
        
        let env = AuzureEnvironment(endpoints:[
            .resourceManager : "http://localhost:3000"
        ])
        
        let atc = AzureTokenCredentials(environment: env, tenantId: "", subscriptionId: "")
        
        self.azureClient = AzureClient(atc: atc)
            .withRequestInterceptor(LogRequestInterceptor(showOptions: .all))
            .withResponseInterceptor(LogResponseInterceptor(showOptions: .all))
        
        flattenedProduct1 = FlattenedProductData()
        flattenedProduct1?.id = "1"
        flattenedProduct1?.location = "Building 44"
        flattenedProduct1?.name = "Resource1"
        flattenedProduct1?.properties = FlattenedProductPropertiesData()
        flattenedProduct1?.properties?.provisioningState = "Succeeded"
        flattenedProduct1?.properties?.provisioningStateValues = ProvisioningStateValues.OK
        flattenedProduct1?.properties?.pname = "Product1"
        flattenedProduct1?.properties?.type = "Flat"
        flattenedProduct1?.tags = ["tag1":"value1","tag2":"value3"]
        flattenedProduct1?.type = "Microsoft.Web/sites"
        
        flattenedProduct2 = FlattenedProductData()
        flattenedProduct2?.id = "2"
        flattenedProduct2?.location = "Building 44"
        flattenedProduct2?.name = "Resource2"
        
        flattenedProduct3 = FlattenedProductData()
        flattenedProduct3?.id = "3"
        flattenedProduct3?.name = "Resource3"
        
        // ===
        
        resource1 = ResourceData()
        resource1?.location = "West US"
        resource1?.tags = ["tag1":"value1","tag2":"value3"]
        
        resource2 = ResourceData()
        resource2?.location = "Building 44"
        
        // ===
 
        flattenedProduct4 = FlattenedProductData()
        flattenedProduct4?.location = "West US"
        flattenedProduct4?.tags = ["tag1":"value1","tag2":"value3"]
        flattenedProduct4?.properties = FlattenedProductPropertiesData()
        flattenedProduct4?.properties?.pname = "Product1"
        flattenedProduct4?.properties?.type = "Flat"
        
        flattenedProduct5 = FlattenedProductData()
        flattenedProduct5?.location = "Building 44"
        flattenedProduct5?.properties = FlattenedProductPropertiesData()
        flattenedProduct5?.properties?.pname = "Product2"
        flattenedProduct5?.properties?.type = "Flat"
        
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSingleItemArrayOrMap() {
        do {
            let res = try XMLDecoder().decode(SingleItemCollection?.self, from: xmlSingleItemCollection.data(using: .utf8)!)
            XCTAssertNotNil(res)
            XCTAssertEqual("Hello", res!.array[0])
            XCTAssertEqual("Hello", res!.map["string"])
            XCTAssertEqual("Hello", res!.arrayOp[0])
            XCTAssertEqual("Hello", res!.mapOp["string"]!)
            XCTAssertEqual(nil, res!.arrayOpEmpty[0])
            XCTAssertNil(res!.mapOpEmpty["string"]!)
            XCTAssertEqual(nil, res!.mapOpEmpty["string"]!)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func testVariousTypesXML() {
        print("\n=================== #0 VariousTypesXML\n")
        
        do {
            let res = try XMLDecoder().decode(VariousTypesXML?.self, from: xmlVariousTypes.data(using: .utf8)!)
            XCTAssertNotNil(res)
            XCTAssertEqual(9223372036854775806, res!.dictionaryOfInt?["big"])
            XCTAssertEqual(18446744073709551614, res!.dictionaryOfUInt?["big"])
            XCTAssertEqual(3.402823e+37, res!.dictionaryOfFloat?["big"])
            XCTAssertEqual(2.225073858507201e-307, res!.dictionaryOfDouble?["big"])
            XCTAssertEqual("Aa23$$", (res!.dictionaryOfString?["random"])!)
            XCTAssertEqual(nil, (res!.dictionaryOfString?["empty"])!)
            XCTAssertEqual(true, res!.dictionaryOfBool?["hi"])
            XCTAssertEqual(18446744073709551615, res!.arrayOfUInt?.first)
            
            XCTAssertEqual(127, res!.dictionaryOfInt8?["biggest"])
            XCTAssertEqual(32767, res!.dictionaryOfInt16?["biggest"])
            XCTAssertEqual(-2147483648, res!.dictionaryOfInt32?["smallest"])
            XCTAssertEqual(-9223372036854775808, res!.dictionaryOfInt64?["smallest"])
            
            XCTAssertEqual(255, res!.dictionaryOfUInt8?["biggest"])
            XCTAssertEqual(65535, res!.dictionaryOfUInt16?["biggest"])
            XCTAssertEqual(4294967295, res!.dictionaryOfUInt32?["biggest"])
            XCTAssertEqual(18446744073709551615, res!.dictionaryOfUInt64?["biggest"])
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func testNullValuesXML() {
        print("\n=================== #0 NullValuesXML\n")
        
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ssZ"
            let xmlDecoder = XMLDecoder()
            xmlDecoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            let res = try xmlDecoder.decode(NullValuesXML?.self, from: xmlNullValuesXML.data(using: .utf8)!)
            XCTAssertNotNil(res)
            XCTAssertNil(res!.int)
            XCTAssertNil(res!.string)
            XCTAssertNil(res!.float)
            XCTAssertNil(res!.double)
            XCTAssertNil(res!.bool)
            XCTAssertNil(res!.date)
            
            XCTAssertEqual(45689, res!.int1)
            XCTAssertEqual("AS23@#", res!.string1)
            XCTAssertEqual(1.12345, res!.float1)
            XCTAssertEqual(1.123456789012345, res!.double1)
            XCTAssertEqual(true, res!.bool1)
            
            if let date = res!.date {
                let calendar = Calendar.current
                let components = calendar.dateComponents(in: TimeZone(identifier: "GMT")!, from: date)
                XCTAssertEqual(2018, components.year)
                XCTAssertEqual(1, components.month)
                XCTAssertEqual(18, components.day)
                XCTAssertEqual(2, components.hour)
                XCTAssertEqual(1, components.minute)
                XCTAssertEqual(17, components.second)
                XCTAssertEqual(5, components.weekday)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
/*
    func test_putArray() {
        print("\n=================== #1.1 putArray\n")
        
        let cmd = ModelFlatteningNamespace.PutArrayCommand()
        cmd.resourceArray = [resource1, resource2]
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
*/
    func test_getArray() {
        print("\n=================== #1.2 getArray\n")
        
        //let cmd = ModelFlatteningNamespace.GetArrayCommand()
        let expectedResult = [flattenedProduct1, flattenedProduct2, flattenedProduct3]
        
        do {
            let res = try XMLDecoder().decode([FlattenedProductData?]?.self, from: xmlArray.data(using: .utf8)!)
            XCTAssertNotNil(res)
            for i in 0..<expectedResult.count {
                XCTAssertEqual(expectedResult[i]?.id, res![i]?.id)
                XCTAssertEqual(expectedResult[i]?.name, res![i]?.name)
                XCTAssertEqual(expectedResult[i]?.location, res![i]?.location)
                XCTAssertEqual(expectedResult[i]?.type, res![i]?.type)
            }
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
/*
    func test_putDictionary() {
        print("\n=================== #3.1 putDictionary\n")
        
        let cmd = ModelFlatteningNamespace.PutDictionaryCommand()
        cmd.resourceDictionary = [
            "Resource1" : flattenedProduct4,
            "Resource2" : flattenedProduct5,
        ]
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
 */
    func test_getDictionary() {
        print("\n=================== #3.2 getDictionary\n")
        
        //let cmd = ModelFlatteningNamespace.GetDictionaryCommand()
        let expectedResult = [
            "Product1" : flattenedProduct1,
            "Product2" : flattenedProduct2,
            "Product3" : flattenedProduct3
        ]
        
        do {
            let res = try XMLDecoder().decode([String:FlattenedProductData?]?.self, from: xmlDictionary.data(using: .utf8)!)
            XCTAssertNotNil(res)
            for (key, value) in expectedResult {
                XCTAssertEqual(value?.id, res![key]??.id)
                XCTAssertEqual(value?.name, res![key]??.name)
                XCTAssertEqual(value?.location, res![key]??.location)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
    
/*
    func test_putResourceCollection() {
        print("\n=================== #3.1 putResourceCollection\n")
        
        var flattenedProduct1: FlattenedProductProtocol? = FlattenedProductData()
        flattenedProduct1?.location = "West US"
        flattenedProduct1?.tags = ["tag1":"value1","tag2":"value3"]
        flattenedProduct1?.properties = FlattenedProductPropertiesData()
        flattenedProduct1?.properties?.pname = "Product1"
        flattenedProduct1?.properties?.type = "Flat"
        
        var flattenedProduct2: FlattenedProductProtocol? = FlattenedProductData()
        flattenedProduct2?.location = "East US"
        flattenedProduct2?.properties = FlattenedProductPropertiesData()
        flattenedProduct2?.properties?.pname = "Product2"
        flattenedProduct2?.properties?.type = "Flat"
        
        var flattenedProduct3: FlattenedProductProtocol? = FlattenedProductData()
        flattenedProduct3?.location = "Building 44"
        flattenedProduct3?.properties = FlattenedProductPropertiesData()
        flattenedProduct3?.properties?.pname = "Product2"
        flattenedProduct3?.properties?.type = "Flat"
        
        var flattenedProduct4: FlattenedProductProtocol? = FlattenedProductData()
        flattenedProduct4?.location = "India"
        flattenedProduct4?.properties = FlattenedProductPropertiesData()
        flattenedProduct4?.properties?.pname = "Azure"
        flattenedProduct4?.properties?.type = "Flat"
        
        let cmd = ModelFlatteningNamespace.PutResourceCollectionCommand()
        cmd.resourceComplexObject = ResourceCollectionData()

        cmd.resourceComplexObject?.arrayofresources = [flattenedProduct1, flattenedProduct2]
        
        cmd.resourceComplexObject?.dictionaryofresources = [
            "Resource1" : flattenedProduct1,
            "Resource2" : flattenedProduct3,
        ]
        
        cmd.resourceComplexObject?.productresource = flattenedProduct4
        
        do {
            let res = try cmd.execute(client: self.azureClient)
            XCTAssertNil(res)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
 */
    func test_getResourceCollection() {
        print("\n=================== #3.2 getResourceCollection\n")
 
        var flattenedProduct4: FlattenedProductProtocol? = FlattenedProductData()
        flattenedProduct4?.id = "4"
        flattenedProduct4?.location = "Building 44"
        flattenedProduct4?.name = "Resource4"
        flattenedProduct4?.properties = FlattenedProductPropertiesData()
        flattenedProduct4?.properties?.provisioningState = "Succeeded"
        flattenedProduct4?.properties?.provisioningStateValues = ProvisioningStateValues.OK
        flattenedProduct4?.properties?.pname = "Product4"
        flattenedProduct4?.properties?.type = "Flat"
        flattenedProduct4?.tags = ["tag1":"value1","tag2":"value3"]
        flattenedProduct4?.type = "Microsoft.Web/sites"
        
        var flattenedProduct5: FlattenedProductProtocol? = FlattenedProductData()
        flattenedProduct5?.id = "5"
        flattenedProduct5?.location = "Building 44"
        flattenedProduct5?.name = "Resource5"
        
        var flattenedProduct6: FlattenedProductProtocol? = FlattenedProductData()
        flattenedProduct6?.id = "6"
        flattenedProduct6?.name = "Resource6"
        
        var flattenedProduct7: FlattenedProductProtocol? = FlattenedProductData()
        flattenedProduct7?.id = "7"
        flattenedProduct7?.location = "Building 44"
        flattenedProduct7?.name = "Resource7"
        
        //let cmd = ModelFlatteningNamespace.GetResourceCollectionCommand()
        var expectedResult = ResourceCollectionData()
        expectedResult.dictionaryofresources = [
            "Product1" : flattenedProduct1,
            "Product2" : flattenedProduct2,
            "Product3" : flattenedProduct3,
        ]
        expectedResult.arrayofresources = [flattenedProduct4, flattenedProduct5, flattenedProduct6]
        expectedResult.productresource = flattenedProduct7
        
        do {
            let res = try XMLDecoder().decode(ResourceCollectionData?.self, from: xmlResourceCollection.data(using: .utf8)!)
            
            XCTAssertNotNil(res!.dictionaryofresources)
            guard let dict = res!.dictionaryofresources else {
                XCTFail(); return
            }
            for (key, value) in expectedResult.dictionaryofresources! {
                guard let keyExists = dict[key], let valNotNil = keyExists else {
                    XCTFail(); return
                }
                XCTAssertEqual(value?.id, valNotNil.id)
                XCTAssertEqual(value?.name, valNotNil.name)
                XCTAssertEqual(value?.location, valNotNil.location)
            }
            
            XCTAssertNotNil(res!.arrayofresources)
            guard let array = res!.arrayofresources else {
                XCTFail(); return
            }
            
            for i in 0 ..< expectedResult.arrayofresources!.count {
                XCTAssertEqual(array[i]?.id, expectedResult.arrayofresources![i]?.id)
                XCTAssertEqual(array[i]?.name, expectedResult.arrayofresources![i]?.name)
                XCTAssertEqual(array[i]?.location, expectedResult.arrayofresources![i]?.location)
            }
            
            guard let resource = expectedResult.productresource else {
                XCTFail(); return
            }
            
            XCTAssertEqual(expectedResult.productresource?.id, resource.id)
            XCTAssertEqual(expectedResult.productresource?.name, resource.name)
            XCTAssertEqual(expectedResult.productresource?.location, resource.location)
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
}

