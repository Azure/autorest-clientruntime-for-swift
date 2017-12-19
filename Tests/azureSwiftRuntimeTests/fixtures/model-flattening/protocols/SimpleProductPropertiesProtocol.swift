import Foundation
// SimpleProductPropertiesProtocol is the product documentation.
public protocol SimpleProductPropertiesProtocol : Codable {
     var maxProductDisplayName: String? { get set }
     var capacity: String? { get set }
     var maxProductImage: ProductUrlProtocol? { get set }
}
