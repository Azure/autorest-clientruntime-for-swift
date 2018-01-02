import Foundation
import azureSwiftRuntime
// DeleteAsyncRelativeRetryNoStatus long running delete request, service returns a 202 to the initial request. Poll the
// endpoint indicated in the azureAsyncOperation header for operation status This method may poll for completion.
// Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any
// outstanding HTTP requests.
class LROSADsDeleteAsyncRelativeRetryNoStatusCommand : BaseCommand {

    override init() {
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = true
        self.path = "/lro/error/deleteasync/retry/nostatus"
    }

    override func preCall()  {
    }


    public func execute(client: RuntimeClient) throws -> Decodable? {
        return try client.execute(command: self)
    }
    
    override func returnFunc(data: Data) throws -> Decodable? {
        return try AzureJSONDecoder().decode(ProductType?.self, from: data)
    }
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (ProductTypeProtocol?, Error?) -> Void) {
        client.executeAsyncLRO (command: self) {
            (result: ProductType?, error: Error?)  in
            completionHandler(result, error)
        }
    }
}
