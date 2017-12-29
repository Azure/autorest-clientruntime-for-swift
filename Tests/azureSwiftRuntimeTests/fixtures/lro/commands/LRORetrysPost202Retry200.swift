import Foundation
import azureSwiftRuntime
// Post202Retry200 long running post request, service returns a 500, then a 202 to the initial request, with 'Location'
// and 'retryAfter' headers, Polls return a 200 with a response body after success This method may poll for
// completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
class LRORetrysPost202Retry200Command : BaseCommand {
    var product :  ProductTypeProtocol?

    override init() {
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = true
        self.path = "/lro/retryerror/post/202/retry/200"
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
    
    override func returnFunc(data: Data) throws -> Decodable? {
        return try AzureJSONDecoder().decode(ProductType?.self, from: data)
    }
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (ProductTypeProtocol?, Error?) -> Void) {
        client.executeAsyncLRO(command: self, completionHandler:  {
            (result: ProductType?, error: Error?)  in
            
            completionHandler(result, error)
        })
    }
}
