import Foundation
public struct ProductData : ProductProtocol {
    public var properties: ProductPropertiesProtocol?

    enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.properties) {
        properties = try container.decode(ProductPropertiesData?.self, forKey: .properties)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.properties != nil {try container.encode(properties as! ProductPropertiesData?, forKey: .properties)}
  }
}
