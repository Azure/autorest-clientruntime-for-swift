import Foundation
public struct SimpleProductData : SimpleProductProtocol, BaseProductProtocol {
    public var productId: String?
    public var description: String?
    public var details: SimpleProductPropertiesProtocol?

    enum CodingKeys: String, CodingKey {
        case productId = "base_product_id"
        case description = "base_product_description"
        case details = "details"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.productId) {
        productId = try container.decode(String?.self, forKey: .productId)
    }
    if container.contains(.description) {
        description = try container.decode(String?.self, forKey: .description)
    }
    if container.contains(.details) {
        details = try container.decode(SimpleProductPropertiesData?.self, forKey: .details)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.productId != nil {try container.encode(productId, forKey: .productId)}
    if self.description != nil {try container.encode(description, forKey: .description)}
    if self.details != nil {try container.encode(details as! SimpleProductPropertiesData?, forKey: .details)}
  }
}
