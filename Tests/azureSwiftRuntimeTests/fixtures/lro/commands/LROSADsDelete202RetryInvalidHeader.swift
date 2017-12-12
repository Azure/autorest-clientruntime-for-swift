import Foundation
import azureSwiftRuntime
// Delete202RetryInvalidHeader long running delete request, service returns a 202 to the initial request receing a
// reponse with an invalid 'Location' and 'retryAfter' headers This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
class LROSADsDelete202RetryInvalidHeaderCommand : BaseCommand {

    override init() {
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/lro/error/delete/202/retry/invalidheader"
    }

    override func preCall()  {
    }


    public func execute(client: RuntimeClient) throws -> Decodable? {
        return try client.execute(command: self)
    }
}
