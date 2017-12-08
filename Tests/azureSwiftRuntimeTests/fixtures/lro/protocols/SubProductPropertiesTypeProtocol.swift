import Foundation
// SubProductPropertiesTypeProtocol is
public protocol SubProductPropertiesTypeProtocol : Codable {
     var provisioningState: String? { get set }
     var provisioningStateValues: ProvisioningStateValues? { get set }
}
