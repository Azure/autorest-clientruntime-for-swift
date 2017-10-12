//
//  AuthData.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Alva D Bandy on 10/4/17.
//
import SwiftyJSON

public class AuthData {
    let grantType: String = "client_credentials"
    let resource: String = "https://management.core.windows.net/"
    var authURL: String
    var clientCredentials: String
    var clientSecret: String
    var subscription: String
    var tenant: String
    var accessToken: String? = nil
    var refreshToken: String? = nil
    var baseURL: String
    
    init(authURL: String,
         clientCredentials: String,
         clientSecret: String,
         subscription: String,
         tenant: String,
         baseURL: String) {
        self.authURL = authURL
        self.clientCredentials = clientCredentials
        self.clientSecret = clientSecret
        self.subscription = subscription
        self.tenant = tenant
        self.baseURL = baseURL
    }
    
    public static func load(location: String) -> AuthData? {
        guard let content = try? String(contentsOfFile: location, encoding: String.Encoding.utf8) else {
            return nil
        }
        
        guard let dataFromString = content.data(using: .utf8, allowLossyConversion: false) else {
            return nil
        }
        
        guard let jsonContent = try? JSON(data: dataFromString) else {
            return nil;
        }
        
        return AuthData(authURL: jsonContent["authURL"].string!,
                        clientCredentials: jsonContent["client"].string!,
                        clientSecret: jsonContent["key"].string!,
                        subscription: jsonContent["subscription"].string!,
                        tenant: jsonContent["tenant"].string!,
                        baseURL: jsonContent["baseURL"].string!)
    }
}
