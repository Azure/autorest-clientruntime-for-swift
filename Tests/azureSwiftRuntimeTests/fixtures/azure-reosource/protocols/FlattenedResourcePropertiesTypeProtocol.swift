import Foundation
// FlattenedResourcePropertiesTypeProtocol is
public protocol FlattenedResourcePropertiesTypeProtocol : Codable {
     var pname: String? { get set }
     var lsize: Int32? { get set }
     var provisioningState: String? { get set }
}
