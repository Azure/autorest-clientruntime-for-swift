//
//  AzureTokentCredentials.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Vladimir Shcherbakov on 10/31/17.
//

import Foundation
import RxSwift

protocol ServiceClientCredential {
    func authHeaderValue(url: String?) throws -> String
}

protocol TokenCredentials: ServiceClientCredential {
    func getToken(forResource: String) throws -> String
}

public class AzureTokenCredentials: TokenCredentials {
    let tenantId: String
    let environment: Environment
    public var defaultSubscriptionId: String?
    
    let db = DisposeBag()
    
    public init(environment: Environment, tenantId: String, subscriptionId: String?) {
        self.environment = environment
        self.tenantId = tenantId
        self.defaultSubscriptionId = subscriptionId
    }
    
    convenience init(tenantId: String, subscriptionId: String?) {
        self.init(environment: AuzureEnvironment.azure, tenantId: tenantId, subscriptionId: subscriptionId)
    }
   
    func authHeaderValue(url: String?) throws -> String {
        guard
            let resource = (url == nil)
                ? self.environment.url(forEndpoint: .activeDirectory)
                : try! self.getResource(fromUri: url!) else {
            throw RuntimeError.general(message: "Can't get resource Url")
        }
        let token = try self.getToken(forResource: resource)
        return "Bearer " + token
    }
    
    private func getResource(fromUri: String) throws -> String {
        guard
            let url = URL(string: fromUri),
            let host = url.host
        else {
            throw ClientCredentialError.badUrl
        }
        var resource: String?
        environment.endpoints.forEach {
            (key, value) in
            if host.contains(value) {
                switch key {
                case .keyVault:
                    resource = "https://" + value.replacingOccurrences(of: "^\\.", with: "", options: .regularExpression )
                case .graph:
                    resource = self.environment.url(forEndpoint: .graph)
                case .dataLakeStore,
                     .dataLakeAnalystic:
                    resource = self.environment.url(forEndpoint: .dataLake)
                default:
                    resource = self.environment.url(forEndpoint: .activeDirectory)
                }
            }
        }
        guard resource != nil else {
            throw ClientCredentialError.badUrl
        }
        
        return resource!
    }
    
    // abstract
    func getToken(forResource: String) throws -> String {
        //throw ClientCredentialError.abstructFuncCall
        return "NULL"
    }
}

enum ClientCredentialError: Error {
    case badUrl
    case abstructFuncCall
    case cantGetToken
}
