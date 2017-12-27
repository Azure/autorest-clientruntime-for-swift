import Foundation
import azureSwiftRuntime
// Post202RetryInvalidHeader long running post request, service returns a 202 to the initial request, with invalid
// 'Location' and 'retryAfter' headers. This method may poll for completion. Polling can be canceled by passing the
// cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
class LROSADsPost202RetryInvalidHeaderCommand : BaseCommand {
    var product :  ProductTypeProtocol?

    override init() {
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = true
        self.path = "/lro/error/post/202/retry/invalidheader"
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
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (Decodable?, Error?) -> Void) {
        client.executeAsyncLRO(command: self, completionHandler:  {
            (decodable, error)  in
            completionHandler(decodable, error)
        })
    }
}
