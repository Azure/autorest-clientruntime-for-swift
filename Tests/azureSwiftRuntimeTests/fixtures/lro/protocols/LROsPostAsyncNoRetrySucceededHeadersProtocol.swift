import Foundation
// LROsPostAsyncNoRetrySucceededHeadersProtocol is defines headers for postAsyncNoRetrySucceeded operation.
public protocol LROsPostAsyncNoRetrySucceededHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
