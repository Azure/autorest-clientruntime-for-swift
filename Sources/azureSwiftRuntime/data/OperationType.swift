import Foundation
public struct OperationType : OperationTypeProtocol {
    public var name: String?
    public var display: OperationDisplayTypeProtocol?
    public var origin: String?
    public var properties: OperationPropertiesTypeProtocol?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case display = "display"
        case origin = "origin"
        case properties = "properties"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(String?.self, forKey: .name)
    display = try container.decode(OperationDisplayType?.self, forKey: .display)
    origin = try container.decode(String?.self, forKey: .origin)
    properties = try container.decode(OperationPropertiesType?.self, forKey: .properties)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    try container.encode(display as! OperationDisplayType?, forKey: .display)
    try container.encode(origin, forKey: .origin)
    try container.encode(properties as! OperationPropertiesType?, forKey: .properties)
  }
}
