import Foundation
// ProductProtocol is
public protocol ProductProtocol : Codable {
     var properties: ProductPropertiesProtocol? { get set }
}
