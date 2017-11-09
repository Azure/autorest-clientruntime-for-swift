import Foundation
public struct StorageAccountPropertiesType : StorageAccountPropertiesTypeProtocol {
    public var provisioningState: ProvisioningStateEnum?
    public var primaryEndpoints: EndpointsTypeProtocol?
    public var primaryLocation: String?
    public var statusOfPrimary: AccountStatusEnum?
    public var lastGeoFailoverTime: Date?
    public var secondaryLocation: String?
    public var statusOfSecondary: AccountStatusEnum?
    public var creationTime: Date?
    public var customDomain: CustomDomainTypeProtocol?
    public var secondaryEndpoints: EndpointsTypeProtocol?
    public var encryption: EncryptionTypeProtocol?
    public var accessTier: AccessTierEnum?
    public var supportsHttpsTrafficOnly: Bool?
    public var networkAcls: NetworkRuleSetTypeProtocol?

    enum CodingKeys: String, CodingKey {
        case provisioningState = "provisioningState"
        case primaryEndpoints = "primaryEndpoints"
        case primaryLocation = "primaryLocation"
        case statusOfPrimary = "statusOfPrimary"
        case lastGeoFailoverTime = "lastGeoFailoverTime"
        case secondaryLocation = "secondaryLocation"
        case statusOfSecondary = "statusOfSecondary"
        case creationTime = "creationTime"
        case customDomain = "customDomain"
        case secondaryEndpoints = "secondaryEndpoints"
        case encryption = "encryption"
        case accessTier = "accessTier"
        case supportsHttpsTrafficOnly = "supportsHttpsTrafficOnly"
        case networkAcls = "networkAcls"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    provisioningState = try container.decode(ProvisioningStateEnum?.self, forKey: .provisioningState)
    primaryEndpoints = try container.decode(EndpointsType?.self, forKey: .primaryEndpoints)
    primaryLocation = try container.decode(String?.self, forKey: .primaryLocation)
    statusOfPrimary = try container.decode(AccountStatusEnum?.self, forKey: .statusOfPrimary)
    lastGeoFailoverTime = try container.decode(Date?.self, forKey: .lastGeoFailoverTime)
    secondaryLocation = try container.decode(String?.self, forKey: .secondaryLocation)
    statusOfSecondary = try container.decode(AccountStatusEnum?.self, forKey: .statusOfSecondary)
    creationTime = try container.decode(Date?.self, forKey: .creationTime)
    customDomain = try container.decode(CustomDomainType?.self, forKey: .customDomain)
    secondaryEndpoints = try container.decode(EndpointsType?.self, forKey: .secondaryEndpoints)
    encryption = try container.decode(EncryptionType?.self, forKey: .encryption)
    accessTier = try container.decode(AccessTierEnum?.self, forKey: .accessTier)
    supportsHttpsTrafficOnly = try container.decode(Bool?.self, forKey: .supportsHttpsTrafficOnly)
    networkAcls = try container.decode(NetworkRuleSetType?.self, forKey: .networkAcls)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(provisioningState as! ProvisioningStateEnum?, forKey: .provisioningState)
    try container.encode(primaryEndpoints as! EndpointsType?, forKey: .primaryEndpoints)
    try container.encode(primaryLocation, forKey: .primaryLocation)
    try container.encode(statusOfPrimary as! AccountStatusEnum?, forKey: .statusOfPrimary)
    try container.encode(lastGeoFailoverTime, forKey: .lastGeoFailoverTime)
    try container.encode(secondaryLocation, forKey: .secondaryLocation)
    try container.encode(statusOfSecondary as! AccountStatusEnum?, forKey: .statusOfSecondary)
    try container.encode(creationTime, forKey: .creationTime)
    try container.encode(customDomain as! CustomDomainType?, forKey: .customDomain)
    try container.encode(secondaryEndpoints as! EndpointsType?, forKey: .secondaryEndpoints)
    try container.encode(encryption as! EncryptionType?, forKey: .encryption)
    try container.encode(accessTier as! AccessTierEnum?, forKey: .accessTier)
    try container.encode(supportsHttpsTrafficOnly, forKey: .supportsHttpsTrafficOnly)
    try container.encode(networkAcls as! NetworkRuleSetType?, forKey: .networkAcls)
  }
}
