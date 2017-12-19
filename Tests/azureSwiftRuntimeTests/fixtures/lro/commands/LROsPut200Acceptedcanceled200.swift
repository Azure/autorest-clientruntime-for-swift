import Foundation
import azureSwiftRuntime
// Put200Acceptedcanceled200 long running put request, service returns a 201 to the initial request, with an entity
// that contains ProvisioningState=’Creating’.  Polls return this value until the last poll returns a ‘200’ with
// ProvisioningState=’Canceled’ This method may poll for completion. Polling can be canceled by passing the cancel
// channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
class LROsPut200Acceptedcanceled200Command : BaseCommand {
    var product :  ProductTypeProtocol?

    override init() {
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/lro/put/200/accepted/canceled/200"
    }

    override func preCall()  {
        self.body = product
    }

    override func encodeBody() throws -> Data? {
        return try JsonRequestEncoder.encode(encodable: product as! ProductType?)
    }

    override func returnFunc(data: Data) throws -> Decodable? {
        return try JsonResponseDecoder.decode(ProductType?.self, from: data)
    }
    
    public func execute(client: RuntimeClient) throws -> ProductTypeProtocol? {
        return try client.execute(command: self) as! ProductTypeProtocol?
    }
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (ProductTypeProtocol?, Error?) -> Void) {
        client.executeAsyncLRO(command: self) {
            (decodable, error)  in
            completionHandler(decodable as? ProductType, error)
        }
    }
}
