import Foundation
// LROSADsPutAsyncRelativeRetryNoStatusHeadersProtocol is defines headers for putAsyncRelativeRetryNoStatus operation.
public protocol LROSADsPutAsyncRelativeRetryNoStatusHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
