import Foundation
// LROsDeleteAsyncRetrycanceledHeadersProtocol is defines headers for deleteAsyncRetrycanceled operation.
public protocol LROsDeleteAsyncRetrycanceledHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
     var retryAfter: Int32? { get set }
}
