import Foundation
// LROSADsDeleteNonRetry400HeadersProtocol is defines headers for deleteNonRetry400 operation.
public protocol LROSADsDeleteNonRetry400HeadersProtocol : Codable {
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
