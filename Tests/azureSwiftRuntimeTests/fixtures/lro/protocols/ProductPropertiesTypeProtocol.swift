import Foundation
// ProductPropertiesTypeProtocol is
public protocol ProductPropertiesTypeProtocol : Codable {
     var provisioningState: String? { get set }
     var provisioningStateValues: ProvisioningStateValues? { get set }
}
