import Foundation
import azureSwiftRuntime
// DeleteAsyncRelativeRetrySucceeded long running delete request, service returns a 500, then a 202 to the initial
// request. Poll the endpoint indicated in the azureAsyncOperation header for operation status This method may poll
// for completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
class LRORetrysDeleteAsyncRelativeRetrySucceededCommand : BaseCommand {

    override init() {
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/lro/retryerror/deleteasync/retry/succeeded"
    }

    override func preCall()  {
    }

    public func execute(client: RuntimeClient) throws -> Decodable? {
        return try client.execute(command: self)
    }
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (Error?) -> Void) {
        client.executeAsyncLRO (command: self) {
            error in
            completionHandler(error)
        }
    }
}
