//
//  AuthTests.swift
//  azureSwiftRuntimeTests
//
//  Created by Vladimir Shcherbakov on 10/27/17.
//

import XCTest
import RxSwift
@testable import azureSwiftRuntime

class AuthTests: XCTestCase {

    let envVarName = "AUTH_FILE_PATH"
    var filepath = String()
    let timeout: TimeInterval = 100.0
    
    var applicationTokenCredentials: ApplicationTokenCredentials!
    var azureClient: AzureClient!
    
    override func setUp() {
        continueAfterFailure = false
        super.setUp()
        guard let filepath = self.getEnvironmentVar(name: envVarName.uppercased()) else {
            XCTFail("Azure auth file path is not set in env var \(envVarName))")
            return
        }  
        self.filepath = filepath
        
        self.applicationTokenCredentials = try? ApplicationTokenCredentials.fromFile(path: filepath)
        let headersToHide = ["Authorization"]
        self.azureClient = AzureClient(atc: applicationTokenCredentials)
            .withRequestInterceptor(LogRequestInterceptor(showOptions: .all).withHeadersToHide(headersToHide))
            .withResponseInterceptor(LogResponseInterceptor(showOptions: .all))
    }
    
    func testAuthFile() {
        XCTAssertNoThrow(try AuthFile.parseJsonFile(path: filepath))
    }
    
    func testApplicationTokenCredentials() {
        let e = expectation(description: "Wait for HTTP request to compleate")
        do {
            let atc = try ApplicationTokenCredentials.fromFile(path: filepath)
            _ = try atc.authHeaderValue(url: nil)
            e.fulfill()
        } catch {
            print("=== Error:", error)
            XCTFail()
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }

    class AzureAuthCommand : BaseCommand {
        
        override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions?api-version=2016-06-01"
        }
        
        override func returnFunc(data: Data) throws -> Decodable? {
            return try JsonResponseDecoder.decode(Subscription?.self, from: data)
        }
        
        public func executeAsync(client: RuntimeClient, completionHandler: @escaping (Subscription?, Error?) -> Void) throws {
            try client.executeAsyncLRO(command: self, completionHandler:  {
                (decodable, error)  in
                
                completionHandler(decodable as? Subscription, error)
            })
        }
        
        public func executeAsync(client: RuntimeClient) throws -> Observable<Subscription?> {
            return try client.executeAsync(command: self)
        }
        
        struct Subscription : Codable {
            let value: [SubscriptionData]
        }
        
        struct SubscriptionData : Codable {
            let id: String
            let subscriptionId: String
            let displayName: String
            let state: String
            let subscriptionPolicies: SubscriptionPolicies
            let authorizationSource: String?
            
            struct SubscriptionPolicies : Codable {
                let locationPlacementId: String
                let quotaId: String
                let spendingLimit: String
            }
        }
    }
    
    func testAzureAuth() {
        print("\n=================== #1 AzureAuth()\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        
        let cmd = AzureAuthCommand()
        
        do {
            try cmd.executeAsync(client: self.azureClient) {
                result, error in
                defer { e.fulfill() }
                
                do {
                    if let curError = error {
                        throw curError
                    }
                    
                    XCTAssertNotNil(result)
                    if let subscriptions = result?.value {
                        if subscriptions.count > 0 {
                            print("Subscriptions ===")
                            for sub in subscriptions {
                                print("\tname: \(sub.displayName), id: \(sub.subscriptionId)")
                            }
                            
                        }
                    }
                    
                } catch {
                    print("=== Error:", error)
                    XCTFail(error.localizedDescription)
                }
                //XCTAssertNil(error)
            }
            
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testAzureAuthObservable() {
        print("\n=================== #2 AzureAuthObservable\n")
        let e = expectation(description: "Wait for HTTP request to compleate")
        let disposeBag = DisposeBag()
        let cmd = AzureAuthCommand()
        do {
            try cmd.executeAsync(client: self.azureClient).subscribe(
                onNext: { result in
                    defer { e.fulfill() }
                    XCTAssertNotNil(result)
                    if let subscriptions = result?.value {
                        if subscriptions.count > 0 {
                            print("Subscriptions ===")
                            for sub in subscriptions {
                                print("\tname: \(sub.displayName), id: \(sub.subscriptionId)")
                            }
                            
                        }
                    }
                },
                    onError: { error in
                        print("=== Error:", error)
                        XCTFail(error.localizedDescription)
                }
            ).disposed(by: disposeBag)
        } catch {
            print("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    // === private helpers

    func getEnvironmentVar(name: String) -> String? {
        guard let rawValue = getenv(name) else { return nil }
        return String(utf8String: rawValue)
    }

}
