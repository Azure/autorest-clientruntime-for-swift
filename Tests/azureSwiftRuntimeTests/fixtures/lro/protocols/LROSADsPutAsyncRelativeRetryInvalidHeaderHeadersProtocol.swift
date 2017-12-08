import Foundation
// LROSADsPutAsyncRelativeRetryInvalidHeaderHeadersProtocol is defines headers for putAsyncRelativeRetryInvalidHeader
// operation.
public protocol LROSADsPutAsyncRelativeRetryInvalidHeaderHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
