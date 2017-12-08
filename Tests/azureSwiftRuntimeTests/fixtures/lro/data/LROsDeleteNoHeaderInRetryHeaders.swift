import Foundation
public struct LROsDeleteNoHeaderInRetryHeaders : LROsDeleteNoHeaderInRetryHeadersProtocol {
    public var Location: String?

    enum CodingKeys: String, CodingKey {
        case Location = "Location"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.Location) {
        Location = try container.decode(String?.self, forKey: .Location)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.Location != nil {try container.encode(Location, forKey: .Location)}
  }
}
