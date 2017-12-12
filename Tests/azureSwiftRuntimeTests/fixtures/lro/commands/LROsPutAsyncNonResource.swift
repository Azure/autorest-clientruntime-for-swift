import Foundation
import azureSwiftRuntime
import RxSwift

// PutAsyncNonResource long running put request with non resource. This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
class LROsPutAsyncNonResourceCommand : BaseCommand {
    var sku :  SkuTypeProtocol?

    override init() {
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/lro/putnonresourceasync/202/200"
    }

    override func preCall()  {
        self.body = sku
    }

    override func encodeBody() throws -> Data? {
        return try JsonRequestEncoder.encode(encodable: sku as! SkuType?)
    }

    override func returnFunc(data: Data) throws -> Decodable? {
        return try JsonResponseDecoder.decode(SkuType?.self, from: data)
    }
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (SkuTypeProtocol?, Error?) -> Void) throws {
        
        try client.executeAsyncLRO(command: self, completionHandler:  {
            (decodable, error)  in
            
            completionHandler(decodable as? SkuType, error)
        })
    }
    
}
