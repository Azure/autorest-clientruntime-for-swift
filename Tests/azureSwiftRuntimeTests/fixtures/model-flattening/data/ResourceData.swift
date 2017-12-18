import Foundation
public struct ResourceData : ResourceProtocol {
    public var id: String?
    public var type: String?
    public var tags: [String:String?]?
    public var location: String?
    public var name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case tags = "tags"
        case location = "location"
        case name = "name"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.id) {
        id = try container.decode(String?.self, forKey: .id)
    }
    if container.contains(.type) {
        type = try container.decode(String?.self, forKey: .type)
    }
    if container.contains(.tags) {
        tags = try container.decode([String:String?]?.self, forKey: .tags)
    }
    if container.contains(.location) {
        location = try container.decode(String?.self, forKey: .location)
    }
    if container.contains(.name) {
        name = try container.decode(String?.self, forKey: .name)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.id != nil {try container.encode(id, forKey: .id)}
    if self.type != nil {try container.encode(type, forKey: .type)}
    if self.tags != nil {try container.encode(tags, forKey: .tags)}
    if self.location != nil {try container.encode(location, forKey: .location)}
    if self.name != nil {try container.encode(name, forKey: .name)}
  }
}
