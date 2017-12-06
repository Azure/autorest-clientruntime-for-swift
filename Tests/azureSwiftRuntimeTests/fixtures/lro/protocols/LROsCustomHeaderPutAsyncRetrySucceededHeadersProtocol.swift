import Foundation
// LROsCustomHeaderPutAsyncRetrySucceededHeadersProtocol is defines headers for putAsyncRetrySucceeded operation.
public protocol LROsCustomHeaderPutAsyncRetrySucceededHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
