import Foundation
// LROsPostAsyncRetryFailedHeadersProtocol is defines headers for postAsyncRetryFailed operation.
public protocol LROsPostAsyncRetryFailedHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
