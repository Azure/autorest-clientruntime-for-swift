import Foundation
import azureSwiftRuntime
// Put201CreatingSucceeded200 x-ms-client-request-id = 9C4D50EE-2D56-4CD3-8152-34347DC9F2B0 is required message header
// for all requests. Long running put request, service returns a 201 to the initial request, with an entity that
// contains ProvisioningState=’Creating’.  Polls return this value until the last poll returns a ‘200’ with
// ProvisioningState=’Succeeded’ This method may poll for completion. Polling can be canceled by passing the cancel
// channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
class LROsCustomHeaderPut201CreatingSucceeded200Command : BaseCommand {
    var product :  ProductTypeProtocol?

    override init() {
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/lro/customheader/put/201/creating/succeeded/200"
    }

    override func preCall()  {
        self.body = product
    }

    override func encodeBody() throws -> Data? {
        return try JsonRequestEncoder.encode(encodable:product as! ProductType?)
    }

    public func execute(client: RuntimeClient) throws -> ProductTypeProtocol? {
        return try client.execute(command: self) as! ProductTypeProtocol?
    }
    
    override func returnFunc(data: Data) throws -> Decodable? {
        return try JsonResponseDecoder.decode(ProductType?.self, from: data)
    }
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (ProductTypeProtocol?, Error?) -> Void) {
        
        client.executeAsyncLRO(command: self, completionHandler:  {
            (decodable, error)  in
            
            completionHandler(decodable as? ProductType, error)
        })
    }
}
