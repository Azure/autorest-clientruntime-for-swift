import Foundation
import azureSwiftRuntime
// PostAsyncRelativeRetrySucceeded long running post request, service returns a 500, then a 202 to the initial request,
// with an entity that contains ProvisioningState=’Creating’. Poll the endpoint indicated in the azureAsyncOperation
// header for operation status This method may poll for completion. Polling can be canceled by passing the cancel
// channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
class LRORetrysPostAsyncRelativeRetrySucceededCommand : BaseCommand {
    var product :  ProductTypeProtocol?

    override init() {
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = true
        self.path = "/lro/retryerror/postasync/retry/succeeded"
    }

    override func preCall()  {
        self.body = product
    }

    override func encodeBody() throws -> Data? {
        return try CoderFactory.encoder(for: .json).encode(product as! ProductType?)
    }

    public func execute(client: RuntimeClient) throws -> Decodable? {
        return try client.execute(command: self)
    }
    }
