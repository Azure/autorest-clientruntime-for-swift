import Alamofire
import RxSwift

class AzureAuthticate {
    var authData: AuthData;
    
    init(authData: AuthData) {
        self.authData = authData
    }
    
    func connect() -> Observable<Void> {
        return Observable<Void>.create({observable in
            let parameters: Parameters = ["grant_type":  self.authData.grantType,
                                          "client_id": self.authData.clientCredentials,
                                          "client_secret": self.authData.clientSecret,
                                          "resource": self.authData.resource]
            let request = Alamofire.request("\(self.authData.authURL)\(self.authData.tenant)/oauth2/token",
                method: .post, parameters: parameters).responseJSON(completionHandler: { response in
                    if response.result.isSuccess {
                        if let data = response.result.value as? [String: Any] {
                                self.authData.accessToken = data["access_token"] as? String;
                            observable.onNext(Void())
                        }else {
                            observable.onError(RestfulError("test"));
                        }
                    }
                })
            
            return Disposables.create {
                request.cancel()
            }
        })
    }
    
}
