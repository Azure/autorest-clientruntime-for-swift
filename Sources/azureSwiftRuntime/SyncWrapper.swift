//
//  SyncWrapper.swift
//  RxSwift
//
//  Created by Alva D Bandy on 6/22/19.
//

import Foundation
import RxSwift

public class SyncWrapper {
    public class func EnsureCompletion<T>(with: Observable<T>) -> Event<T>? {
        let group = DispatchGroup()
        group.enter()
        var retVal: Event<T>?
        // avoid deadlocks by not using .main queue here
        _ = with.subscribe( { event in
            if retVal == nil {
                retVal = event
                group.leave()
            }
        })
        
        group.wait()
        return retVal
    }
}
