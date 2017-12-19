import Foundation
public struct SimpleProductPropertiesData : SimpleProductPropertiesProtocol {
    public var maxProductDisplayName: String?
    public var capacity: String?
    public var maxProductImage: ProductUrlProtocol?

    enum CodingKeys: String, CodingKey {
        case maxProductDisplayName = "max_product_display_name"
        case capacity = "max_product_capacity"
        case maxProductImage = "max_product_image"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.maxProductDisplayName) {
        maxProductDisplayName = try container.decode(String?.self, forKey: .maxProductDisplayName)
    }
    if container.contains(.capacity) {
        capacity = try container.decode(String?.self, forKey: .capacity)
    }
    if container.contains(.maxProductImage) {
        maxProductImage = try container.decode(ProductUrlData?.self, forKey: .maxProductImage)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.maxProductDisplayName != nil {try container.encode(maxProductDisplayName, forKey: .maxProductDisplayName)}
    if self.capacity != nil {try container.encode(capacity, forKey: .capacity)}
    if self.maxProductImage != nil {try container.encode(maxProductImage as! ProductUrlData?, forKey: .maxProductImage)}
  }
}
