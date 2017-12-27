import Foundation
import azureSwiftRuntime
// Put201CreatingSucceeded200 long running put request, service returns a 201 to the initial request, with an entity
// that contains ProvisioningState=’Creating’.  Polls return this value until the last poll returns a ‘200’ with
// ProvisioningState=’Succeeded’ This method may poll for completion. Polling can be canceled by passing the cancel
// channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
class LROsPut201CreatingSucceeded200Command : BaseCommand {
    var product :  ProductTypeProtocol?

    override init() {
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/lro/put/201/creating/succeeded/200"
    }

    override func preCall()  {
        self.body = product
    }

    override func encodeBody() throws -> Data? {
        return try CoderFactory.encoder(for: .json).encode(product as! ProductType?)
    }

    override func returnFunc(data: Data) throws -> Decodable? {
        return try CoderFactory.decoder(for: .json).decode(ProductType?.self, from: data)
    }
    
    public func execute(client: RuntimeClient) throws -> ProductTypeProtocol? {
        return try client.execute(command: self) as! ProductTypeProtocol?
    }
  
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (ProductTypeProtocol?, Error?) -> Void) {
        
        client.executeAsyncLRO(command: self, completionHandler:  {
            (decodable, error)  in
            
            completionHandler(decodable as? ProductType, error)
        })
    }
}
