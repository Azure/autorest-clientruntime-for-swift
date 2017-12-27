import Foundation
import azureSwiftRuntime
// DeleteNoHeaderInRetry long running delete request, service returns a location header in the initial request.
// Subsequent calls to operation status do not contain location header. This method may poll for completion. Polling
// can be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any
// outstanding HTTP requests.
class LROsDeleteNoHeaderInRetryCommand : BaseCommand {

    override init() {
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/lro/delete/noheader"
    }

    override func preCall()  {
}


    public func execute(client: RuntimeClient) throws -> Decodable? {
        return try client.execute(command: self)
    }
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (Decodable?, Error?) -> Void) {
        
        client.executeAsyncLRO(command: self, completionHandler:  {
            (decodable, error)  in
            
            completionHandler(decodable, error)
        })
    }
}
