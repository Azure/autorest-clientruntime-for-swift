import Foundation
// LRORetrysDeleteAsyncRelativeRetrySucceededHeadersProtocol is defines headers for deleteAsyncRelativeRetrySucceeded
// operation.
public protocol LRORetrysDeleteAsyncRelativeRetrySucceededHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
