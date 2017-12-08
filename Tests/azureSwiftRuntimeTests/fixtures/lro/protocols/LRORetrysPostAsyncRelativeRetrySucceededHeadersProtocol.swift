import Foundation
// LRORetrysPostAsyncRelativeRetrySucceededHeadersProtocol is defines headers for postAsyncRelativeRetrySucceeded
// operation.
public protocol LRORetrysPostAsyncRelativeRetrySucceededHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
