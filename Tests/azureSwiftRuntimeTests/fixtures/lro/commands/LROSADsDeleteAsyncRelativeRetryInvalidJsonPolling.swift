import Foundation
import azureSwiftRuntime
// DeleteAsyncRelativeRetryInvalidJsonPolling long running delete request, service returns a 202 to the initial
// request. Poll the endpoint indicated in the azureAsyncOperation header for operation status This method may poll
// for completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
class LROSADsDeleteAsyncRelativeRetryInvalidJsonPollingCommand : BaseCommand {

    override init() {
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/lro/error/deleteasync/retry/invalidjsonpolling"
    }

    override func preCall()  {
}


    public func execute(client: RuntimeClient) throws -> Decodable? {
        return try client.execute(command: self)
    }
    }
