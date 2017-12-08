import Foundation
// LROSADsDeleteAsyncRelativeRetryNoStatusHeadersProtocol is defines headers for deleteAsyncRelativeRetryNoStatus
// operation.
public protocol LROSADsDeleteAsyncRelativeRetryNoStatusHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
