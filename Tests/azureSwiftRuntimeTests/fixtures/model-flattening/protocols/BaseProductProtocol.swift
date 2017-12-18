import Foundation
// BaseProductProtocol is the product documentation.
public protocol BaseProductProtocol : Codable {
     var productId: String? { get set }
     var description: String? { get set }
}
