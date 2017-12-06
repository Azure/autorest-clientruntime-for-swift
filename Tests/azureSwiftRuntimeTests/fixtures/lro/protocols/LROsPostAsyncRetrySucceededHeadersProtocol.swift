import Foundation
// LROsPostAsyncRetrySucceededHeadersProtocol is defines headers for postAsyncRetrySucceeded operation.
public protocol LROsPostAsyncRetrySucceededHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
