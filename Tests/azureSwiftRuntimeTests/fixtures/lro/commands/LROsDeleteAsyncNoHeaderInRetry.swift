import Foundation
import azureSwiftRuntime
// DeleteAsyncNoHeaderInRetry long running delete request, service returns an azureAsyncOperation header in the
// initial request. Subsequent calls to operation status do not contain azureAsyncOperation header. This method may
// poll for completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to
// cancel polling and any outstanding HTTP requests.
class LROsDeleteAsyncNoHeaderInRetryCommand : BaseCommand {

    override init() {
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/lro/deleteasync/noheader/202/204"
    }

    override func preCall()  {
}


    public func execute(client: RuntimeClient) throws -> Decodable? {
        return try client.execute(command: self)
    }
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (Decodable?, Error?) -> Void) throws {
        
        try client.executeAsync(command: self, completionHandler:  {
            (decodable, error)  in
            
            completionHandler(decodable, error)
        })
    }
}
