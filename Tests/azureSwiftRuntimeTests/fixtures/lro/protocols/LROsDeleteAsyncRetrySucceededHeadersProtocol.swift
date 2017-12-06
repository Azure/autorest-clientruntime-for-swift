import Foundation
// LROsDeleteAsyncRetrySucceededHeadersProtocol is defines headers for deleteAsyncRetrySucceeded operation.
public protocol LROsDeleteAsyncRetrySucceededHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
