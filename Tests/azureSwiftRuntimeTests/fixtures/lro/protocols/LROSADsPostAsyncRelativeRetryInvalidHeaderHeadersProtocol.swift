import Foundation
// LROSADsPostAsyncRelativeRetryInvalidHeaderHeadersProtocol is defines headers for postAsyncRelativeRetryInvalidHeader
// operation.
public protocol LROSADsPostAsyncRelativeRetryInvalidHeaderHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
