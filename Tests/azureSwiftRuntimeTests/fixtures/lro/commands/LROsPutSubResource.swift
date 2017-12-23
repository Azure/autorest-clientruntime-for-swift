import Foundation
import azureSwiftRuntime
// PutSubResource long running put request with sub resource. This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
class LROsPutSubResourceCommand : BaseCommand {
    var product :  SubProductTypeProtocol?

    override init() {
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/lro/putsubresource/202/200"
    }

    override func preCall()  {
        self.body = product
    }

    override func encodeBody() throws -> Data? {
        return try CoderFactory.encoder(for: .json).encode(product as! SubProductType?)
    }

    public func execute(client: RuntimeClient) throws -> SubProductTypeProtocol? {
        return try client.execute(command: self) as! SubProductTypeProtocol?
    }
    
    override func returnFunc(data: Data) throws -> Decodable? {
        return try CoderFactory.decoder(for: .json).decode(SubProductType?.self, from: data)
    }
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (SubProductTypeProtocol?, Error?) -> Void) throws {
        try client.executeAsyncLRO(command: self, completionHandler:  {
            (decodable, error)  in
            
            completionHandler(decodable as? SubProductType, error)
        })
    }
}
