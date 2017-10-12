//
//  RestPost.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Alva D Bandy on 10/9/17.
//
import Alamofire
import RxSwift
import SwiftyJSON

public final class RestPost: Restful {
    let url: String
    let data: [String: Any]
    let helper: AzureRestHelper
    
    init(helper: AzureRestHelper, url:String, data: [String: Any]) {
        self.helper = helper
        self.url = url;
        self.data = data;
    }
    
    public func call() -> Observable<JSON?> {
        let headers = helper.getHeadersWithAuthAndCustomSet()
        return Observable<JSON?>.create({observable in
            let request = Alamofire.request(self.url, method: .post, parameters: self.data, encoding: JSONEncoding.default, headers: headers)
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

