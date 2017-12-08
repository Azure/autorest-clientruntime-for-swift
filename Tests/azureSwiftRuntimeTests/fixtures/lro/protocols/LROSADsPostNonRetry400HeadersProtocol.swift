import Foundation
// LROSADsPostNonRetry400HeadersProtocol is defines headers for postNonRetry400 operation.
public protocol LROSADsPostNonRetry400HeadersProtocol : Codable {
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
