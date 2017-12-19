import Foundation
// FlattenedProductPropertiesProtocol is
public protocol FlattenedProductPropertiesProtocol : Codable {
     var pname: String? { get set }
     var type: String? { get set }
     var provisioningStateValues: ProvisioningStateValues? { get set }
     var provisioningState: String? { get set }
}
