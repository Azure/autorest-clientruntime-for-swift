import Foundation
public struct LROsPutNoHeaderInRetryHeaders : LROsPutNoHeaderInRetryHeadersProtocol {
    public var location: String?

    enum CodingKeys: String, CodingKey {
        case location = "location"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.location) {
        location = try container.decode(String?.self, forKey: .location)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.location != nil {try container.encode(location, forKey: .location)}
  }
}
