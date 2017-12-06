import Foundation
// LROSADsDeleteAsyncRelativeRetryInvalidHeaderHeadersProtocol is defines headers for
// deleteAsyncRelativeRetryInvalidHeader operation.
public protocol LROSADsDeleteAsyncRelativeRetryInvalidHeaderHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
