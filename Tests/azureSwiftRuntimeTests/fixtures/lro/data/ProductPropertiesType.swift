import Foundation
public struct ProductPropertiesType : ProductPropertiesTypeProtocol {
    public var provisioningState: String?
    public var provisioningStateValues: ProvisioningStateValues?

    enum CodingKeys: String, CodingKey {
        case provisioningState = "provisioningState"
        case provisioningStateValues = "provisioningStateValues"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.provisioningState) {
        provisioningState = try container.decode(String?.self, forKey: .provisioningState)
    }
    if container.contains(.provisioningStateValues) {
        provisioningStateValues = try container.decode(ProvisioningStateValues?.self, forKey: .provisioningStateValues)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.provisioningState != nil {try container.encode(provisioningState, forKey: .provisioningState)}
    if self.provisioningStateValues != nil {try container.encode(provisioningStateValues, forKey: .provisioningStateValues)}
  }
}
