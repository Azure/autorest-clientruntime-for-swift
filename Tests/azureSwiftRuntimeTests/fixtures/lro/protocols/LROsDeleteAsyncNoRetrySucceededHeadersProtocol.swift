import Foundation
// LROsDeleteAsyncNoRetrySucceededHeadersProtocol is defines headers for deleteAsyncNoRetrySucceeded operation.
public protocol LROsDeleteAsyncNoRetrySucceededHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
