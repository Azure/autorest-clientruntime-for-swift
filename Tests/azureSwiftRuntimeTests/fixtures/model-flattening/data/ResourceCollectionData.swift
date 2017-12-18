import Foundation
public struct ResourceCollectionData : ResourceCollectionProtocol {
    public var productresource: FlattenedProductProtocol?
    public var arrayofresources: [FlattenedProductProtocol?]?
    public var dictionaryofresources: [String:FlattenedProductProtocol?]?

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
            productresource = try container.decode(FlattenedProductData?.self, forKey: .productresource)
        }
        if container.contains(.arrayofresources) {
            arrayofresources = try container.decode([FlattenedProductData?]?.self, forKey: .arrayofresources)
        }
        if container.contains(.dictionaryofresources) {
            dictionaryofresources = try container.decode([String:FlattenedProductData?]?.self, forKey: .dictionaryofresources)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if self.productresource != nil {try container.encode(productresource as! FlattenedProductData?, forKey: .productresource)}
        if self.arrayofresources != nil {try container.encode(arrayofresources as! [FlattenedProductData?]?, forKey: .arrayofresources)}
        if self.dictionaryofresources != nil {try container.encode(dictionaryofresources as! [String:FlattenedProductData?]?, forKey: .dictionaryofresources)}
    }
}
