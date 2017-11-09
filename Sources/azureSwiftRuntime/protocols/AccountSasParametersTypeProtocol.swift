import Foundation
// AccountSasParametersTypeProtocol is the parameters to list SAS credentials of a storage account.
public protocol AccountSasParametersTypeProtocol : Codable {
     var signedServices: ServicesEnum? { get set }
     var signedResourceTypes: SignedResourceTypesEnum? { get set }
     var signedPermission: PermissionsEnum? { get set }
     var signedIp: String? { get set }
     var signedProtocol: HttpProtocolEnum? { get set }
     var signedStart: Date? { get set }
     var signedExpiry: Date? { get set }
     var keyToSign: String? { get set }
}
