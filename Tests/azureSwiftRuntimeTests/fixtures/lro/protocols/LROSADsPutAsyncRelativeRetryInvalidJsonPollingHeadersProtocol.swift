import Foundation
// LROSADsPutAsyncRelativeRetryInvalidJsonPollingHeadersProtocol is defines headers for
// putAsyncRelativeRetryInvalidJsonPolling operation.
public protocol LROSADsPutAsyncRelativeRetryInvalidJsonPollingHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
