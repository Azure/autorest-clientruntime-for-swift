import Foundation
public struct SkuType : SkuTypeProtocol {
    public var name: String?
    public var id: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.name) {
        name = try container.decode(String?.self, forKey: .name)
    }
    if container.contains(.id) {
        id = try container.decode(String?.self, forKey: .id)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.name != nil {try container.encode(name, forKey: .name)}
    if self.id != nil {try container.encode(id, forKey: .id)}
  }
}
