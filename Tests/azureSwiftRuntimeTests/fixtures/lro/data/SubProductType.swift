import Foundation
public struct SubProductType : SubProductTypeProtocol, SubResourceTypeProtocol {
    public var id: String?
    public var properties: SubProductPropertiesTypeProtocol?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case properties = "properties"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.id) {
        id = try container.decode(String?.self, forKey: .id)
    }
    if container.contains(.properties) {
        properties = try container.decode(SubProductPropertiesType?.self, forKey: .properties)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.id != nil {try container.encode(id, forKey: .id)}
    if self.properties != nil {try container.encode(properties as! SubProductPropertiesType?, forKey: .properties)}
  }
}
