import Foundation
public struct ProductUrlData : ProductUrlProtocol, GenericUrlProtocol {
    public var genericValue: String?
    public var odatavalue: String?

    enum CodingKeys: String, CodingKey {
        case genericValue = "generic_value"
        case odatavalue = "@odata.value"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.genericValue) {
        genericValue = try container.decode(String?.self, forKey: .genericValue)
    }
    if container.contains(.odatavalue) {
        odatavalue = try container.decode(String?.self, forKey: .odatavalue)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.genericValue != nil {try container.encode(genericValue, forKey: .genericValue)}
    if self.odatavalue != nil {try container.encode(odatavalue, forKey: .odatavalue)}
  }
}
