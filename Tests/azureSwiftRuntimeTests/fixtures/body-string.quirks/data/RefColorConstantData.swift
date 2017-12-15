import Foundation
public struct RefColorConstantData : RefColorConstantProtocol {
    public var colorConstant: String?
    public var field1: String?

    enum CodingKeys: String, CodingKey {
        case colorConstant = "ColorConstant"
        case field1 = "field1"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.colorConstant) {
        colorConstant = try container.decode(String?.self, forKey: .colorConstant)
    }
    if container.contains(.field1) {
        field1 = try container.decode(String?.self, forKey: .field1)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.colorConstant != nil {try container.encode(colorConstant, forKey: .colorConstant)}
    if self.field1 != nil {try container.encode(field1, forKey: .field1)}
  }
}
