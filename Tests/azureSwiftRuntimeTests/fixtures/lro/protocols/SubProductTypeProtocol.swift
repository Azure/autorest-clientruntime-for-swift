import Foundation
// SubProductTypeProtocol is
public protocol SubProductTypeProtocol : Codable {
     var id: String? { get set }
     var properties: SubProductPropertiesTypeProtocol? { get set }
}
