import Foundation
// LROsDeleteAsyncRetryFailedHeadersProtocol is defines headers for deleteAsyncRetryFailed operation.
public protocol LROsDeleteAsyncRetryFailedHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
