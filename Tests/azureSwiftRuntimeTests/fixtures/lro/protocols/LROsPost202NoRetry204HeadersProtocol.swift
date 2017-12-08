import Foundation
// LROsPost202NoRetry204HeadersProtocol is defines headers for post202NoRetry204 operation.
public protocol LROsPost202NoRetry204HeadersProtocol : Codable {
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
