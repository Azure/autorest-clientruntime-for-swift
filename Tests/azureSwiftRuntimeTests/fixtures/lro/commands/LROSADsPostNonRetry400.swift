import Foundation
import azureSwiftRuntime
// PostNonRetry400 long running post request, service returns a 400 with no error body This method may poll for
// completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
class LROSADsPostNonRetry400Command : BaseCommand {
    var product :  ProductTypeProtocol?

    override init() {
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = true
        self.path = "/lro/nonretryerror/post/400"
    }

    override func preCall()  {
        self.body = product
    }

    override func encodeBody() throws -> Data? {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(product as! ProductType?)
        return jsonData
    }

    public func execute(client: RuntimeClient) throws -> Decodable? {
        return try client.execute(command: self)
    }
    }
