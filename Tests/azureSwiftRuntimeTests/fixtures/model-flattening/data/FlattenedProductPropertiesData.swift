import Foundation
public struct FlattenedProductPropertiesData : FlattenedProductPropertiesProtocol {
    public var pname: String?
    public var type: String?
    public var provisioningStateValues: ProvisioningStateValues?
    public var provisioningState: String?

    enum CodingKeys: String, CodingKey {
        case pname = "p.name"
        case type = "type"
        case provisioningStateValues = "provisioningStateValues"
        case provisioningState = "provisioningState"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.pname) {
        pname = try container.decode(String?.self, forKey: .pname)
    }
    if container.contains(.type) {
        type = try container.decode(String?.self, forKey: .type)
    }
    if container.contains(.provisioningStateValues) {
        provisioningStateValues = try container.decode(ProvisioningStateValues?.self, forKey: .provisioningStateValues)
    }
    if container.contains(.provisioningState) {
        provisioningState = try container.decode(String?.self, forKey: .provisioningState)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.pname != nil {try container.encode(pname, forKey: .pname)}
    if self.type != nil {try container.encode(type, forKey: .type)}
    if self.provisioningStateValues != nil {try container.encode(provisioningStateValues, forKey: .provisioningStateValues)}
    if self.provisioningState != nil {try container.encode(provisioningState, forKey: .provisioningState)}
  }
}
