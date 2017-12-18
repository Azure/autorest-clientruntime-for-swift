import Foundation
public struct ProductWrapperData : ProductWrapperProtocol {
    public var property: WrappedProductProtocol?

    enum CodingKeys: String, CodingKey {
        case property = "property"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.property) {
        property = try container.decode(WrappedProductData?.self, forKey: .property)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.property != nil {try container.encode(property as! WrappedProductData?, forKey: .property)}
  }
}
