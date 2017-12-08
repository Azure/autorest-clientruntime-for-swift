import Foundation
public struct ResourceCollectionType : ResourceCollectionTypeProtocol {
    public var productresource: FlattenedProductTypeProtocol?
    public var arrayofresources: [FlattenedProductTypeProtocol?]?
    public var dictionaryofresources: [String:FlattenedProductTypeProtocol?]?

    enum CodingKeys: String, CodingKey {
        case productresource = "productresource"
        case arrayofresources = "arrayofresources"
        case dictionaryofresources = "dictionaryofresources"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.productresource) {
        productresource = try container.decode(FlattenedProductType?.self, forKey: .productresource)
    }
    if container.contains(.arrayofresources) {
        arrayofresources = try container.decode([FlattenedProductType?]?.self, forKey: .arrayofresources)
    }
    if container.contains(.dictionaryofresources) {
        dictionaryofresources = try container.decode([String:FlattenedProductType?]?.self, forKey: .dictionaryofresources)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.productresource != nil {try container.encode(productresource as! FlattenedProductType?, forKey: .productresource)}
    if self.arrayofresources != nil {try container.encode(arrayofresources as! [FlattenedProductType?]?, forKey: .arrayofresources)}
    if self.dictionaryofresources != nil {try container.encode(dictionaryofresources, forKey: .dictionaryofresources)}
  }
}
