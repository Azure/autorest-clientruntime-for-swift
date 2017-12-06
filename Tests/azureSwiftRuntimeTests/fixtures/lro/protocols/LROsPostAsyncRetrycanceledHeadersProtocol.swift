import Foundation
// LROsPostAsyncRetrycanceledHeadersProtocol is defines headers for postAsyncRetrycanceled operation.
public protocol LROsPostAsyncRetrycanceledHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
