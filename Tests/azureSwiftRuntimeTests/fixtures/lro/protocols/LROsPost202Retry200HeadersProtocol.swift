import Foundation
// LROsPost202Retry200HeadersProtocol is defines headers for post202Retry200 operation.
public protocol LROsPost202Retry200HeadersProtocol : Codable {
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
