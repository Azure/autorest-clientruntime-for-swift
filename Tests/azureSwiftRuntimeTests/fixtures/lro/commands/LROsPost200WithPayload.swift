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

    override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(SkuType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> SkuTypeProtocol? {
        return try client.execute(command: self) as! SkuTypeProtocol?
    }
    
    override func returnFunc(decoder: ResponseDecoder, jsonData: Data) throws -> Decodable? {
        return try decoder.decode(SkuType?.self, from: jsonData)
    }
    
    public func executeAsync(client: RuntimeClient, completionHandler: @escaping (SkuTypeProtocol?, Error?) -> Void) throws {
        
        try client.executeAsync(command: self, completionHandler:  {
            (decodable, error)  in
            
            completionHandler(decodable as? SkuType, error)
        })
    }
}
