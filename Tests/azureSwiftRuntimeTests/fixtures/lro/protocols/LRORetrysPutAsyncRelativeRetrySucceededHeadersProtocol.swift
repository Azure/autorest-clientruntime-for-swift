import Foundation
// LRORetrysPutAsyncRelativeRetrySucceededHeadersProtocol is defines headers for putAsyncRelativeRetrySucceeded
// operation.
public protocol LRORetrysPutAsyncRelativeRetrySucceededHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
