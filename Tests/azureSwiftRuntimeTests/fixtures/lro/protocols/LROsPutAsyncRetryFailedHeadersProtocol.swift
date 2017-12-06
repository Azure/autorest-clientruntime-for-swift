import Foundation
// LROsPutAsyncRetryFailedHeadersProtocol is defines headers for putAsyncRetryFailed operation.
public protocol LROsPutAsyncRetryFailedHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
