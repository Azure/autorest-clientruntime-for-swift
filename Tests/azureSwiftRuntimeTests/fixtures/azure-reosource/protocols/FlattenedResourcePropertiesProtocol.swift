import Foundation
// FlattenedResourcePropertiesProtocol is
public protocol FlattenedResourcePropertiesProtocol : Codable {
     var pname: String? { get set }
     var lsize: Int32? { get set }
     var provisioningState: String? { get set }
}
