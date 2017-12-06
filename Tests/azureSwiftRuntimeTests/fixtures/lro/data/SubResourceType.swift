import Foundation
public struct SubResourceType : SubResourceTypeProtocol {
    public var id: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.id) {
        id = try container.decode(String?.self, forKey: .id)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.id != nil {try container.encode(id, forKey: .id)}
  }
}
