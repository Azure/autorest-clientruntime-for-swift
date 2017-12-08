import Foundation
// LROSADsDeleteAsyncRelativeRetry400HeadersProtocol is defines headers for deleteAsyncRelativeRetry400 operation.
public protocol LROSADsDeleteAsyncRelativeRetry400HeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
