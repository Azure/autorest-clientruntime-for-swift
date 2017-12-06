import Foundation
import azureSwiftRuntime
// PutNonResource long running put request with non resource. This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
class LROsPutNonResourceCommand : BaseCommand {
    var sku :  SkuTypeProtocol?

    override init() {
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/lro/putnonresource/202/200"
    }

    override func preCall()  {
        self.body = sku
    }

    override func encodeBody() throws -> Data? {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(sku as! SkuType?)
        return jsonData
    }

    override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(SkuType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> SkuTypeProtocol? {
        return try client.execute(command: self) as! SkuTypeProtocol?
    }
    
    override func returnFunc(decoder: ResponseDecoder, jsonData: Data) throws -> Decodable? {
        return try decoder.decode(SkuType?.self, from: jsonData)
    }
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (SkuTypeProtocol?, Error?) -> Void) throws {
        
        try client.executeAsync(command: self, completionHandler:  {
            (decodable, error)  in
            
            completionHandler(decodable as? SkuType, error)
        })
    }
}
