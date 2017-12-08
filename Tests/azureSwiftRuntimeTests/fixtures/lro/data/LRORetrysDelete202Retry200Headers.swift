import Foundation
public struct LRORetrysDelete202Retry200Headers : LRORetrysDelete202Retry200HeadersProtocol {
    public var Location: String?
    public var retryAfter: Int32?

    enum CodingKeys: String, CodingKey {
        case Location = "Location"
        case retryAfter = "Retry-After"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.Location) {
        Location = try container.decode(String?.self, forKey: .Location)
    }
    if container.contains(.retryAfter) {
        retryAfter = try container.decode(Int32?.self, forKey: .retryAfter)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.Location != nil {try container.encode(Location, forKey: .Location)}
    if self.retryAfter != nil {try container.encode(retryAfter, forKey: .retryAfter)}
  }
}
