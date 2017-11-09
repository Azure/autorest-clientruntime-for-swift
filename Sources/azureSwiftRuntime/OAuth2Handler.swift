//
//  OAuth2Handler.swift
//  azureSwiftRuntime
//
//  Created by Vladimir Shcherbakov on 11/6/17.
//

import Foundation
import RxSwift
import Alamofire
import RxBlocking

class OAuth2Handler: RequestAdapter {
    private typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?, _ refreshToken: String?) -> Void
    
    private let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        return SessionManager(configuration: configuration)
    }()
    
    let azureTokenCredentials: AzureTokenCredentials
    let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    
    public init(azureTokenCredentials: AzureTokenCredentials) {
        self.azureTokenCredentials = azureTokenCredentials
    }
    
    // MARK: - RequestAdapter
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var request = urlRequest
        let value = try azureTokenCredentials.authHeaderValue(url: nil)
        request.setValue(value, forHTTPHeaderField: "Authorization")
        
        return request
    }
}
