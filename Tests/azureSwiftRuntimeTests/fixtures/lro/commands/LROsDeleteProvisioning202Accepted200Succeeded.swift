import Foundation
import azureSwiftRuntime
// DeleteProvisioning202Accepted200Succeeded long running delete request, service returns a 202 to the initial request,
// with an entity that contains ProvisioningState=’Accepted’.  Polls return this value until the last poll returns a
// ‘200’ with ProvisioningState=’Succeeded’ This method may poll for completion. Polling can be canceled by passing the
// cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
class LROsDeleteProvisioning202Accepted200SucceededCommand : BaseCommand {

    override init() {
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/lro/delete/provisioning/202/accepted/200/succeeded"
    }

    override func preCall()  {
    }


    public func execute(client: RuntimeClient) throws -> ProductTypeProtocol? {
        return try client.execute(command: self) as! ProductTypeProtocol?
    }
    
    override func returnFunc(data: Data) throws -> Decodable? {
        return try CoderFactory.decoder(for: .json).decode(ProductType?.self, from: data)
    }
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (ProductTypeProtocol?, Error?) -> Void) throws {
        
        try client.executeAsyncLRO(command: self, completionHandler:  {
            (decodable, error)  in
            
            completionHandler(decodable as? ProductType, error)
        })
    }
}
