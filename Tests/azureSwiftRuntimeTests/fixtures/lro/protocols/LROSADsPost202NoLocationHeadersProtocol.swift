import Foundation
// LROSADsPost202NoLocationHeadersProtocol is defines headers for post202NoLocation operation.
public protocol LROSADsPost202NoLocationHeadersProtocol : Codable {
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
