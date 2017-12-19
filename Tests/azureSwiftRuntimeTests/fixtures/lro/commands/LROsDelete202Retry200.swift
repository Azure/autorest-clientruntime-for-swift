import Foundation
import azureSwiftRuntime
// Delete202Retry200 long running delete request, service returns a 202 to the initial request. Polls return this value
// until the last poll returns a ‘200’ with ProvisioningState=’Succeeded’ This method may poll for completion. Polling
// can be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any
// outstanding HTTP requests.
class LROsDelete202Retry200Command : BaseCommand {

    override init() {
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/lro/delete/202/retry/200"
    }

    override func preCall()  {
    }

    public func execute(client: RuntimeClient) throws -> ProductTypeProtocol? {
        return try client.execute(command: self) as! ProductTypeProtocol?
    }
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (Decodable?, Error?) -> Void) {
        
        client.executeAsyncLRO(command: self, completionHandler:  {
            (decodable, error)  in
            
            completionHandler(decodable, error)
        })
    }
}
