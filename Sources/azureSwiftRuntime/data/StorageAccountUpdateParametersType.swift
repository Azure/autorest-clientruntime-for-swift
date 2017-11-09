import Foundation
public struct StorageAccountUpdateParametersType : StorageAccountUpdateParametersTypeProtocol {
    public var sku: SkuTypeProtocol?
    public var tags: [String:String?]?
    public var identity: IdentityTypeProtocol?
    public var properties: StorageAccountPropertiesUpdateParametersTypeProtocol?

    enum CodingKeys: String, CodingKey {
        case sku = "sku"
        case tags = "tags"
        case identity = "identity"
        case properties = "properties"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    sku = try container.decode(SkuType?.self, forKey: .sku)
    tags = try container.decode([String:String?]?.self, forKey: .tags)
    identity = try container.decode(IdentityType?.self, forKey: .identity)
    properties = try container.decode(StorageAccountPropertiesUpdateParametersType?.self, forKey: .properties)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(sku as! SkuType?, forKey: .sku)
    try container.encode(tags as! [String:String?]?, forKey: .tags)
    try container.encode(identity as! IdentityType?, forKey: .identity)
    try container.encode(properties as! StorageAccountPropertiesUpdateParametersType?, forKey: .properties)
  }
}
