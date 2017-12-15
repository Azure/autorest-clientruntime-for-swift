import Foundation
import azureSwiftRuntime
// DeleteProvisioning202DeletingFailed200 long running delete request, service returns a 202 to the initial request,
// with an entity that contains ProvisioningState=’Creating’.  Polls return this value until the last poll returns a
// ‘200’ with ProvisioningState=’Failed’ This method may poll for completion. Polling can be canceled by passing the
// cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
class LROsDeleteProvisioning202DeletingFailed200Command : BaseCommand {

    override init() {
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/lro/delete/provisioning/202/deleting/200/failed"
    }

    override func preCall()  {
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
