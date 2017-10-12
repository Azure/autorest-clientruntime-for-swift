//
//  RestGet.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Alva D Bandy on 10/4/17.
//
import Alamofire
import RxSwift
import SwiftyJSON

public final class RestGet: Restful {
    let url: String
    let helper: AzureRestHelper
    
    init(helper: AzureRestHelper, url: String) {
        self.url = url
        self.helper = helper
    }
    
    public func call() -> Observable<JSON?> {
        let headers = self.helper.getHeadersWithAuthAndCustomSet()
        return Observable<JSON?>.create({observable in
            let request = Alamofire.request(self.url, method: .get, headers: headers)
                .responseJSON(completionHandler: { response in
                    if let data = response.result.value as? [String: Any] {
                        observable.onNext(JSON(data))
                    }else {
                        observable.onError(RestfulError("test"));
                    }
                })
            
            return Disposables.create {
                request.cancel()
            }
        })
    }
}
