//
//  AuthData.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Alva D Bandy on 10/4/17.
//
//import SwiftyJSON
import Foundation

public class AuthData {
    let grantType: String = "client_credentials"
    let resource: String
    let authURL: String
    var clientId: String
    var clientSecret: String
    var subscription: String
    var tenant: String
    var accessToken: String? = nil
    var refreshToken: String? = nil
    var baseURL: String
    
    class AuthFileData : Codable {
        let baseURL: String
        let client: String
        let managementURI: String
        let key: String
        let tenant: String
        let authURL: String
        let subscription: String
    }
    
    init? (authURL: String,
           managementUri: String,
           clientId: String,
           clientSecret: String,
           subscription: String,
           tenant: String,
           baseURL: String) {
        
        self.authURL = authURL
        self.resource = managementUri
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.subscription = subscription
        self.tenant = tenant
        self.baseURL = baseURL
    }
    
    public static func load(location: String) -> AuthData? {
        
        let decoder = JSONDecoder()
        let authFileData: AuthFileData
        do {
            let content = try String(contentsOfFile: location, encoding: String.Encoding.utf8)
            guard let jsonData = content.data(using: .utf8, allowLossyConversion: false) else {
                return nil
            }
            authFileData = try decoder.decode(AuthFileData.self, from: jsonData)
        } catch {
            print("Can't parse JSON data: \(error)")
            return nil
        }
        
        return AuthData(authURL: authFileData.authURL,
            managementUri: authFileData.managementURI,
            clientId: authFileData.client,
            clientSecret: authFileData.key,
            subscription: authFileData.subscription,
            tenant: authFileData.tenant,
            baseURL: authFileData.baseURL)
    }
}
