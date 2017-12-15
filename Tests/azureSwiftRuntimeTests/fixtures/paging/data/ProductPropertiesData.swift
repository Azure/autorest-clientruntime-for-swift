import Foundation
public struct ProductPropertiesData : ProductPropertiesProtocol {
    public var id: Int32?
    public var name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.id) {
        id = try container.decode(Int32?.self, forKey: .id)
    }
    if container.contains(.name) {
        name = try container.decode(String?.self, forKey: .name)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.id != nil {try container.encode(id, forKey: .id)}
    if self.name != nil {try container.encode(name, forKey: .name)}
  }
}
