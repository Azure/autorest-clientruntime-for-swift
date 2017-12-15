import Foundation
public struct ProductResultData : ProductResultProtocol {
    
    public var values: [ProductProtocol?]?
    public var nextLink: String?

    enum CodingKeys: String, CodingKey {
        case values = "values"
        case nextLink = "nextLink"
    }

    public init() {
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if container.contains(.values) {
            values = try container.decode([ProductData?]?.self, forKey: .values)
        }
        
        if container.contains(.nextLink) {
            nextLink = try container.decode(String?.self, forKey: .nextLink)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if self.values != nil {try container.encode(values as! [ProductData?]?, forKey: .values)}
        if self.nextLink != nil {try container.encode(nextLink, forKey: .nextLink)}
    }
    
    
}
