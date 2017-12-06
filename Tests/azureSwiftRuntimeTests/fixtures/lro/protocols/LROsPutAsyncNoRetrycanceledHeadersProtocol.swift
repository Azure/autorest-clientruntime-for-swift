import Foundation
// LROsPutAsyncNoRetrycanceledHeadersProtocol is defines headers for putAsyncNoRetrycanceled operation.
public protocol LROsPutAsyncNoRetrycanceledHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
}
