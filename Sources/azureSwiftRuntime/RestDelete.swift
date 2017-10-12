//
//  RestDelete.swift
//  azureSwiftRuntimePackageDescription
//
//  Created by Alva D Bandy on 10/10/17.
//

import Alamofire
import RxSwift
import SwiftyJSON

public final class RestDelete: Restful {
    let url: String
    let helper: AzureRestHelper
    
    init(helper: AzureRestHelper, url: String) {
        self.helper = helper
        self.url = url;
    }
    
    public func call() -> Observable<JSON?> {
        let headers = helper.getHeadersWithAuthAndCustomSet()
        return Observable<JSON?>.create({observable in
            let request = Alamofire.request(self.url, method: .delete, headers: headers)
                .responseData(completionHandler: { response in
                    switch response.result {
                        case .success(let data):
                            observable.onNext(JSON(["deleted": true]))
                        case .failure(let error):
                            observable.onError(error);
                    }
                })
            
            return Disposables.create {
                request.cancel()
            }
        })
    }
}
