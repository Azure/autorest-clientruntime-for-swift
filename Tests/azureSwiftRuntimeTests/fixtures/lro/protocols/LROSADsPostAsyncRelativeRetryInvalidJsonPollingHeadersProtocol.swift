import Foundation
// LROSADsPostAsyncRelativeRetryInvalidJsonPollingHeadersProtocol is defines headers for
// postAsyncRelativeRetryInvalidJsonPolling operation.
public protocol LROSADsPostAsyncRelativeRetryInvalidJsonPollingHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
