import Foundation
// ProductTypeProtocol is
public protocol ProductTypeProtocol : Codable {
     var id: String? { get set }
     var type: String? { get set }
     var tags: [String:String?]? { get set }
     var location: String? { get set }
     var name: String? { get set }
     var properties: ProductPropertiesTypeProtocol? { get set }
}
