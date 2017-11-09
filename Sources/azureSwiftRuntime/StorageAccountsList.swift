// List lists all the storage accounts available under the subscription. Note that storage keys are not returned; use
// the ListKeys operation for this.
import Foundation

class StorageAccountsListCommand: BaseCommand {
    var method = "Get"
    var isLongRunningOperation = false
    let path = "/subscriptions/{subscriptionId}/providers/Microsoft.Storage/storageAccounts"
    var pathParameters = [String: String]()
    var queryParameters = [String: String]()
    var headerParameters = [String: String]()

    var subscriptionId : String? {
        set {
            pathParameters["{subscriptionId}"] = String(newValue!)
        }
        get {
            return pathParameters["{subscriptionId}"]
        }
    }

    var apiVersion : String? {
        set {
            queryParameters["api-version"] = String(newValue!)
        }
        get {
            return queryParameters["api-version"]
        }
     }
    
    //typealias RetType = StorageAccountListResultTypeProtocol
    
    func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        //NSLog(jsonString)
        return try decoder.decode(StorageAccountListResultType?.self, from: jsonString)
    }

    init(apiVersion: String, subscriptionId: String) {
        self.apiVersion = apiVersion
        self.subscriptionId = subscriptionId
    }
}

