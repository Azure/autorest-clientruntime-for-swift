import Alamofire
import RxSwift

public class AzureAuthticate {
    var authData: AuthData;
    
    init(authData: AuthData) {
        self.authData = authData
    }
    
    func connect() -> Observable<Void> {
        return Observable<Void>.create{ observable in
            let uri = "\(self.authData.authURL)\(self.authData.tenant)/oauth2/token"
            let parameters: Parameters = [
                "grant_type":  self.authData.grantType,
                "client_id": self.authData.clientId,
                "client_secret": self.authData.clientSecret,
                "resource": self.authData.resource]
           
            let request = Alamofire
                .request(uri, method: .post, parameters: parameters)
                .responseJSON(completionHandler: { response in
                    //print("Request: \(response.request)")
                    if response.result.isSuccess {
                        if let data = response.result.value as? [String: Any] {
                            self.authData.accessToken = data["access_token"] as? String;
                            observable.onCompleted()
                        } else {
                            observable.onError(RestfulError("test"));
                        }
                    } else {
                        print("No response")
                    }
                })
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
