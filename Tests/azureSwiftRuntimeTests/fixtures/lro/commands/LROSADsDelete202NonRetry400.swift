import Foundation
import azureSwiftRuntime
// Delete202NonRetry400 long running delete request, service returns a 202 with a location header This method may poll
// for completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
class LROSADsDelete202NonRetry400Command : BaseCommand {

    override init() {
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/lro/nonretryerror/delete/202/retry/400"
    }

    override func preCall()  {
    }

    public func execute(client: RuntimeClient) throws -> Decodable? {
        return try client.execute(command: self)
    }
}
