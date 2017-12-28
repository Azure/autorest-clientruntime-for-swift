import Foundation
import azureSwiftRuntime
// DeleteProvisioning202Accepted200Succeeded long running delete request, service returns a 500, then a  202 to the
// initial request, with an entity that contains ProvisioningState=’Accepted’.  Polls return this value until the last
// poll returns a ‘200’ with ProvisioningState=’Succeeded’ This method may poll for completion. Polling can be canceled
// by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
class LRORetrysDeleteProvisioning202Accepted200SucceededCommand : BaseCommand {

    override init() {
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/lro/retryerror/delete/provisioning/202/accepted/200/succeeded"
    }

    override func preCall()  {
    }

    override func returnFunc(data: Data) throws -> Decodable? {
        return try CoderFactory.decoder(for: .json).decode(ProductType?.self, from: data)
    }
    
    public func execute(client: RuntimeClient) throws -> ProductTypeProtocol? {
        return try client.execute(command: self) as! ProductTypeProtocol?
    }
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (ProductTypeProtocol?, Error?) -> Void) {
        client.executeAsyncLRO (command: self) {
            (result: ProductType?, error: Error?)  in
            completionHandler(result, error)
        }
    }
}
