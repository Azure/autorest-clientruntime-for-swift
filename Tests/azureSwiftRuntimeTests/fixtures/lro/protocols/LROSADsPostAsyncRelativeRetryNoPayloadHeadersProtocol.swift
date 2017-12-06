import Foundation
// LROSADsPostAsyncRelativeRetryNoPayloadHeadersProtocol is defines headers for postAsyncRelativeRetryNoPayload
// operation.
public protocol LROSADsPostAsyncRelativeRetryNoPayloadHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
