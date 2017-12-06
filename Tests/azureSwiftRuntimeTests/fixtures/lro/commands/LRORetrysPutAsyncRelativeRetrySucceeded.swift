import Foundation
import azureSwiftRuntime
// PutAsyncRelativeRetrySucceeded long running put request, service returns a 500, then a 200 to the initial request,
// with an entity that contains ProvisioningState=’Creating’. Poll the endpoint indicated in the azureAsyncOperation
// header for operation status This method may poll for completion. Polling can be canceled by passing the cancel
// channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
class LRORetrysPutAsyncRelativeRetrySucceededCommand : BaseCommand {
    var product :  ProductTypeProtocol?

    override init() {
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/lro/retryerror/putasync/retry/succeeded"
    }

    override func preCall()  {
        self.body = product
    }

    override func encodeBody() throws -> Data? {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(product as! ProductType?)
        return jsonData
    }

    override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(ProductType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> ProductTypeProtocol? {
        return try client.execute(command: self) as! ProductTypeProtocol?
    }
    }
