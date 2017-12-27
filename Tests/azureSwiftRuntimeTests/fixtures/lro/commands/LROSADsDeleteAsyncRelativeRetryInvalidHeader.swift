import Foundation
import azureSwiftRuntime
// DeleteAsyncRelativeRetryInvalidHeader long running delete request, service returns a 202 to the initial request. The
// endpoint indicated in the azureAsyncOperation header is invalid This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
class LROSADsDeleteAsyncRelativeRetryInvalidHeaderCommand : BaseCommand {

    override init() {
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/lro/error/deleteasync/retry/invalidheader"
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
