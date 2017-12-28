import Foundation
import azureSwiftRuntime
// Post200WithPayload long running post request, service returns a 202 to the initial request, with 'Location' header.
// Poll returns a 200 with a response body after success. This method may poll for completion. Polling can be canceled
// by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
class LROsPost200WithPayloadCommand : BaseCommand {

    override init() {
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = true
        self.path = "/lro/post/payload/200"
    }

    override func preCall()  {
    }

    public func execute(client: RuntimeClient) throws -> SkuTypeProtocol? {
        return try client.execute(command: self) as! SkuTypeProtocol?
    }
    
    override func returnFunc(data: Data) throws -> Decodable? {
        return try CoderFactory.decoder(for: .json).decode(SkuType?.self, from: data)
    }
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (SkuTypeProtocol?, Error?) -> Void) {
        client.executeAsyncLRO (command: self) {
            (result: SkuType?, error: Error?)  in
            completionHandler(result, error)
        }
    }
}
