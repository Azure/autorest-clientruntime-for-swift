import Foundation
// LROSADsPutAsyncRelativeRetryNoStatusPayloadHeadersProtocol is defines headers for
// putAsyncRelativeRetryNoStatusPayload operation.
public protocol LROSADsPutAsyncRelativeRetryNoStatusPayloadHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
