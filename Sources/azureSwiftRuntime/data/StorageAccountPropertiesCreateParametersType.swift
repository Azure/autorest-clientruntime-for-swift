import Foundation
public struct StorageAccountPropertiesCreateParametersType : StorageAccountPropertiesCreateParametersTypeProtocol {
    public var customDomain: CustomDomainTypeProtocol?
    public var encryption: EncryptionTypeProtocol?
    public var networkAcls: NetworkRuleSetTypeProtocol?
    public var accessTier: AccessTierEnum?
    public var supportsHttpsTrafficOnly: Bool?

    enum CodingKeys: String, CodingKey {
        case customDomain = "customDomain"
        case encryption = "encryption"
        case networkAcls = "networkAcls"
        case accessTier = "accessTier"
        case supportsHttpsTrafficOnly = "supportsHttpsTrafficOnly"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    customDomain = try container.decode(CustomDomainType?.self, forKey: .customDomain)
    encryption = try container.decode(EncryptionType?.self, forKey: .encryption)
    networkAcls = try container.decode(NetworkRuleSetType?.self, forKey: .networkAcls)
    accessTier = try container.decode(AccessTierEnum?.self, forKey: .accessTier)
    supportsHttpsTrafficOnly = try container.decode(Bool?.self, forKey: .supportsHttpsTrafficOnly)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(customDomain as! CustomDomainType?, forKey: .customDomain)
    try container.encode(encryption as! EncryptionType?, forKey: .encryption)
    try container.encode(networkAcls as! NetworkRuleSetType?, forKey: .networkAcls)
    try container.encode(accessTier as! AccessTierEnum?, forKey: .accessTier)
    try container.encode(supportsHttpsTrafficOnly, forKey: .supportsHttpsTrafficOnly)
  }
}
