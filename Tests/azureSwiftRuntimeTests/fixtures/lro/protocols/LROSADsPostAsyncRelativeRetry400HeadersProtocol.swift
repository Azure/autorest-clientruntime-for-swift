import Foundation
// LROSADsPostAsyncRelativeRetry400HeadersProtocol is defines headers for postAsyncRelativeRetry400 operation.
public protocol LROSADsPostAsyncRelativeRetry400HeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
