import Foundation
import azureSwiftRuntime
// PutAsyncRelativeRetryNoStatus long running put request, service returns a 200 to the initial request, with an entity
// that contains ProvisioningState=’Creating’. Poll the endpoint indicated in the azureAsyncOperation header for
// operation status This method may poll for completion. Polling can be canceled by passing the cancel channel
// argument. The channel will be used to cancel polling and any outstanding HTTP requests.
class LROSADsPutAsyncRelativeRetryNoStatusCommand : BaseCommand {
    var product :  ProductTypeProtocol?

    override init() {
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/lro/error/putasync/retry/nostatus"
    }

    override func preCall()  {
        self.body = product
    }

    override func encodeBody() throws -> Data? {
        return try JsonRequestEncoder.encode(encodable: product as! ProductType?)
    }

    public func execute(client: RuntimeClient) throws -> ProductTypeProtocol? {
        return try client.execute(command: self) as! ProductTypeProtocol?
    }
    
    override func returnFunc(data: Data) throws -> Decodable? {
        return try JsonResponseDecoder.decode(ProductType?.self, from: data)
    }
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (ProductTypeProtocol?, Error?) -> Void) throws {
        
        try client.executeAsyncLRO(command: self, completionHandler:  {
            (decodable, error)  in
            
            completionHandler(decodable as? ProductType, error)
        })
    }
}
