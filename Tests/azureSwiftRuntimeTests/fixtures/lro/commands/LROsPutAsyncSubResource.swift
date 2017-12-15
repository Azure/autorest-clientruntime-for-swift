import Foundation
import azureSwiftRuntime
// PutAsyncSubResource long running put request with sub resource. This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
class LROsPutAsyncSubResourceCommand : BaseCommand {
    var product :  SubProductTypeProtocol?

    override init() {
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/lro/putsubresourceasync/202/200"
    }

    override func preCall()  {
        self.body = product
    }

    override func encodeBody() throws -> Data? {
        return try JsonRequestEncoder.encode(encodable: product as! SubProductType?)
    }

    override func returnFunc(data: Data) throws -> Decodable? {
        return try JsonResponseDecoder.decode(SubProductType?.self, from: data)
    }
    
    public func execute(client: RuntimeClient) throws -> SubProductTypeProtocol? {
        return try client.execute(command: self) as! SubProductTypeProtocol?
    }
    
   public func executeAsync(client: RuntimeClient, completionHandler: @escaping (SubProductTypeProtocol?, Error?) -> Void) throws {
        
        try client.executeAsyncLRO(command: self, completionHandler:  {
            (decodable, error)  in
            
            completionHandler(decodable as? SubProductType, error)
        })
    }
}
