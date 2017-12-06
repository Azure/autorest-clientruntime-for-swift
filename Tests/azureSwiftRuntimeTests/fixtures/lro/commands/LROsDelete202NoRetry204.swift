import Foundation
import azureSwiftRuntime
// Delete202NoRetry204 long running delete request, service returns a 202 to the initial request. Polls return this
// value until the last poll returns a ‘200’ with ProvisioningState=’Succeeded’ This method may poll for completion.
// Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any
// outstanding HTTP requests.
class LROsDelete202NoRetry204Command : BaseCommand {

    override init() {
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/lro/delete/202/noretry/204"
    }

    override func preCall()  {
}


    override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(ProductType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> ProductTypeProtocol? {
        return try client.execute(command: self) as! ProductTypeProtocol?
    }
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (Decodable?, Error?) -> Void) throws {
        
        try client.executeAsync(command: self, completionHandler:  {
            (decodable, error)  in
            
            completionHandler(decodable, error)
        })
    }
}
