import Foundation
import azureSwiftRuntime
// Put202Retry200 long running put request, service returns a 202 to the initial request, with a location header that
// points to a polling URL that returns a 200 and an entity that doesn't contains ProvisioningState This method may
// poll for completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to
// cancel polling and any outstanding HTTP requests.
class LROsPut202Retry200Command : BaseCommand {
    var product :  ProductTypeProtocol?

    override init() {
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/lro/put/202/retry/200"
    }

    override func preCall()  {
        self.body = product
    }

    override func encodeBody() throws -> Data? {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(product as! ProductType?)
        return jsonData
    }

    override func returnFunc(decoder: ResponseDecoder, jsonData: Data) throws -> Decodable? {
        return try decoder.decode(ProductType?.self, from: jsonData)
    }
    public func execute(client: RuntimeClient) throws -> ProductTypeProtocol? {
        return try client.execute(command: self) as! ProductTypeProtocol?
    }
    
    // non-blocking
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (ProductTypeProtocol?, Error?) -> Void) throws {
        try client.executeAsync(command: self) {
            decodable, error  in
            
            completionHandler(decodable as? ProductType , error)
        }
    }
}
