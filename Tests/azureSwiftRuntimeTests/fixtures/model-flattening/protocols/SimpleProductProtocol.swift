import Foundation
// SimpleProductProtocol is the product documentation.
public protocol SimpleProductProtocol : Codable {
     var productId: String? { get set }
     var description: String? { get set }
     var details: SimpleProductPropertiesProtocol? { get set }
}
