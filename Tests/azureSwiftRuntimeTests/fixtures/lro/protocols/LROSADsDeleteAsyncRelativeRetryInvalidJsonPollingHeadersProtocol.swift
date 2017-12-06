import Foundation
// LROSADsDeleteAsyncRelativeRetryInvalidJsonPollingHeadersProtocol is defines headers for
// deleteAsyncRelativeRetryInvalidJsonPolling operation.
public protocol LROSADsDeleteAsyncRelativeRetryInvalidJsonPollingHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
