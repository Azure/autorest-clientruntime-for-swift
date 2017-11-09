import Foundation
public struct EncryptionType : EncryptionTypeProtocol {
    public var services: EncryptionServicesTypeProtocol?
    public var keySource: KeySourceEnum?
    public var keyvaultproperties: KeyVaultPropertiesTypeProtocol?

    enum CodingKeys: String, CodingKey {
        case services = "services"
        case keySource = "keySource"
        case keyvaultproperties = "keyvaultproperties"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    services = try container.decode(EncryptionServicesType?.self, forKey: .services)
    keySource = try container.decode(KeySourceEnum?.self, forKey: .keySource)
    keyvaultproperties = try container.decode(KeyVaultPropertiesType?.self, forKey: .keyvaultproperties)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(services as! EncryptionServicesType?, forKey: .services)
    try container.encode(keySource as! KeySourceEnum?, forKey: .keySource)
    try container.encode(keyvaultproperties as! KeyVaultPropertiesType?, forKey: .keyvaultproperties)
  }
}
