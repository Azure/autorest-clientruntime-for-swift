import Foundation
import azureSwiftRuntime
// PutAsyncNoHeaderInRetry long running put request, service returns a 202 to the initial request with
// azureAsyncOperation header. Subsequent calls to operation status do not contain azureAsyncOperation header. This
// method may poll for completion. Polling can be canceled by passing the cancel channel argument. The channel will be
// used to cancel polling and any outstanding HTTP requests.
class LROsPutAsyncNoHeaderInRetryCommand : BaseCommand {
    var product :  ProductTypeProtocol?

    override init() {
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/lro/putasync/noheader/201/200"
    }

    override func preCall()  {
        self.body = product
    }

    override func encodeBody() throws -> Data? {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(product as! ProductType?)
        return jsonData
    }

    override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(ProductType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> ProductTypeProtocol? {
        return try client.execute(command: self) as! ProductTypeProtocol?
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
