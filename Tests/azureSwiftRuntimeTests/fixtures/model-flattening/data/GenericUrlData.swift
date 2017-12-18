import Foundation
public struct GenericUrlData : GenericUrlProtocol {
    public var genericValue: String?

    enum CodingKeys: String, CodingKey {
        case genericValue = "generic_value"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.genericValue) {
        genericValue = try container.decode(String?.self, forKey: .genericValue)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.genericValue != nil {try container.encode(genericValue, forKey: .genericValue)}
  }
}
