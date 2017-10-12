//
//  RestfulFactory.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Alva D Bandy on 10/4/17.
//
import RxSwift
import Alamofire

public protocol AzureRestHelper {
    func getHeadersWithAuthAndCustomSet() -> HTTPHeaders
}

public final class RestfulFactory : AzureRestHelper {
    var azureAuthenticate: AzureAuthticate
    var beforeHeaderFunc: ((HTTPHeaders) -> ())? = nil
    
    var subcriptionId: String {
        return self.azureAuthenticate.authData.subscription
    }

    var baseURL: String {
        return self.azureAuthenticate.authData.baseURL
    }

    init(azureAuthenticate: AzureAuthticate) {
        self.azureAuthenticate = azureAuthenticate;
    }
    
    convenience init() throws {
        guard let authData = AuthData.load(location: "/Users/alvab/myauth.azureAuth.json") else {
            throw RestfulError("Unable to load auth file")
        }
    
        self.init(azureAuthenticate: AzureAuthticate(authData: authData));
    }
    
    public func connect() -> Observable<Void> {
            return self.azureAuthenticate.connect()
    }
    
    public func getHeadersWithAuthAndCustomSet() -> HTTPHeaders {
        var headers = HTTPHeaders()
        if beforeHeaderFunc != nil {
            beforeHeaderFunc!(headers)
        }
        
        headers["Authorization"] = "Bearer \(self.azureAuthenticate.authData.accessToken!)"
        return headers;
    }
    
    public func getCall(verb: RestfulVerb) -> Restful {
        switch(verb) {
            case .Get(let url):
                return RestGet(helper: self, url: url)
            case .Put(let url, let data):
                return RestPut(helper: self, url: url, data: data)
            case .Post(let url, let data):
                return RestPost(helper: self, url: url, data: data)
            case .Patch(let url, let data):
                return RestPost(helper: self, url: url, data: data)
            case .Delete(let url):
                return RestDelete(helper: self, url: url)
        }
    }
}
