import Foundation
public struct ListFlattenedProductType : ListFlattenedProductTypeProtocol {
    public var value: [FlattenedProductTypeProtocol?]?

    enum CodingKeys: String, CodingKey {
        case value = "value"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.value) {
        value = try container.decode([FlattenedProductType?]?.self, forKey: .value)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.value != nil {try container.encode(value as! [FlattenedProductType?]?, forKey: .value)}
  }
}
