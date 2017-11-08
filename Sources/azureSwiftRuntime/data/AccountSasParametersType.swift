import Foundation
public struct AccountSasParametersType : AccountSasParametersTypeProtocol {
    public var signedServices: ServicesEnum?
    public var signedResourceTypes: SignedResourceTypesEnum?
    public var signedPermission: PermissionsEnum?
    public var signedIp: String?
    public var signedProtocol: HttpProtocolEnum?
    public var signedStart: Date?
    public var signedExpiry: Date?
    public var keyToSign: String?

    enum CodingKeys: String, CodingKey {
        case signedServices = "signedServices"
        case signedResourceTypes = "signedResourceTypes"
        case signedPermission = "signedPermission"
        case signedIp = "signedIp"
        case signedProtocol = "signedProtocol"
        case signedStart = "signedStart"
        case signedExpiry = "signedExpiry"
        case keyToSign = "keyToSign"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    signedServices = try container.decode(ServicesEnum?.self, forKey: .signedServices)
    signedResourceTypes = try container.decode(SignedResourceTypesEnum?.self, forKey: .signedResourceTypes)
    signedPermission = try container.decode(PermissionsEnum?.self, forKey: .signedPermission)
    signedIp = try container.decode(String?.self, forKey: .signedIp)
    signedProtocol = try container.decode(HttpProtocolEnum?.self, forKey: .signedProtocol)
    signedStart = try container.decode(Date?.self, forKey: .signedStart)
    signedExpiry = try container.decode(Date?.self, forKey: .signedExpiry)
    keyToSign = try container.decode(String?.self, forKey: .keyToSign)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(signedServices as! ServicesEnum?, forKey: .signedServices)
    try container.encode(signedResourceTypes as! SignedResourceTypesEnum?, forKey: .signedResourceTypes)
    try container.encode(signedPermission as! PermissionsEnum?, forKey: .signedPermission)
    try container.encode(signedIp, forKey: .signedIp)
    try container.encode(signedProtocol as! HttpProtocolEnum?, forKey: .signedProtocol)
    try container.encode(signedStart, forKey: .signedStart)
    try container.encode(signedExpiry, forKey: .signedExpiry)
    try container.encode(keyToSign, forKey: .keyToSign)
  }
}
