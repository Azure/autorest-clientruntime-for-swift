import Foundation
// LROSADsPutAsyncRelativeRetry400HeadersProtocol is defines headers for putAsyncRelativeRetry400 operation.
public protocol LROSADsPutAsyncRelativeRetry400HeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
