import Foundation
public struct ResourceType : ResourceTypeProtocol {
    public var id: String?
    public var name: String?
    public var type: String?
    public var location: String?
    public var tags: [String:String?]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case location = "location"
        case tags = "tags"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(String?.self, forKey: .id)
    name = try container.decode(String?.self, forKey: .name)
    type = try container.decode(String?.self, forKey: .type)
    location = try container.decode(String?.self, forKey: .location)
    tags = try container.decode([String:String?]?.self, forKey: .tags)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(name, forKey: .name)
    try container.encode(type, forKey: .type)
    try container.encode(location, forKey: .location)
    try container.encode(tags as! [String:String?]?, forKey: .tags)
  }
}
