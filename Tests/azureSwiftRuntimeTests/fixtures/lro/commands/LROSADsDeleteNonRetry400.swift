import Foundation
import azureSwiftRuntime
// DeleteNonRetry400 long running delete request, service returns a 400 with an error body This method may poll for
// completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
class LROSADsDeleteNonRetry400Command : BaseCommand {

    override init() {
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/lro/nonretryerror/delete/400"
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
