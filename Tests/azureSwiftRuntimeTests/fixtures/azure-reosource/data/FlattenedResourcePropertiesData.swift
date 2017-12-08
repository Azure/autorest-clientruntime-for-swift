import Foundation
public struct FlattenedResourcePropertiesData : FlattenedResourcePropertiesProtocol {
    public var pname: String?
    public var lsize: Int32?
    public var provisioningState: String?

    enum CodingKeys: String, CodingKey {
        case pname = "pname"
        case lsize = "lsize"
        case provisioningState = "provisioningState"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.pname) {
        pname = try container.decode(String?.self, forKey: .pname)
    }
    if container.contains(.lsize) {
        lsize = try container.decode(Int32?.self, forKey: .lsize)
    }
    if container.contains(.provisioningState) {
        provisioningState = try container.decode(String?.self, forKey: .provisioningState)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.pname != nil {try container.encode(pname, forKey: .pname)}
    if self.lsize != nil {try container.encode(lsize, forKey: .lsize)}
    if self.provisioningState != nil {try container.encode(provisioningState, forKey: .provisioningState)}
  }
}
