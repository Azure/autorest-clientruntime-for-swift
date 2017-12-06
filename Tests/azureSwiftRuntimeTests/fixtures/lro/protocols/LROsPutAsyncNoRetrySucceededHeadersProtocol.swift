import Foundation
// LROsPutAsyncNoRetrySucceededHeadersProtocol is defines headers for putAsyncNoRetrySucceeded operation.
public protocol LROsPutAsyncNoRetrySucceededHeadersProtocol : Codable {
     var azureAsyncOperation: String? { get set }
     var Location: String? { get set }
}
