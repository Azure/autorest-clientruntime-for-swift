import Foundation
// ProductPropertiesProtocol is
public protocol ProductPropertiesProtocol : Codable {
     var id: Int32? { get set }
     var name: String? { get set }
}
