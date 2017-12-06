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
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(product as! SubProductType?)
        return jsonData
    }

    override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(SubProductType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> SubProductTypeProtocol? {
        return try client.execute(command: self) as! SubProductTypeProtocol?
    }
    
    override func returnFunc(decoder: ResponseDecoder, jsonData: Data) throws -> Decodable? {
        return try decoder.decode(ProductType?.self, from: jsonData)
    }
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (ProductTypeProtocol?, Error?) -> Void) throws {
        
        try client.executeAsync(command: self, completionHandler:  {
            (decodable, error)  in
            
            completionHandler(decodable as? ProductType, error)
        })
    }
}
