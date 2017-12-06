import Foundation
public struct LROsDeleteAsyncRetrycanceledHeaders : LROsDeleteAsyncRetrycanceledHeadersProtocol {
    public var azureAsyncOperation: String?
    public var Location: String?
    public var retryAfter: Int32?

    enum CodingKeys: String, CodingKey {
        case azureAsyncOperation = "Azure-AsyncOperation"
        case Location = "Location"
        case retryAfter = "Retry-After"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.azureAsyncOperation) {
        azureAsyncOperation = try container.decode(String?.self, forKey: .azureAsyncOperation)
    }
    if container.contains(.Location) {
        Location = try container.decode(String?.self, forKey: .Location)
    }
    if container.contains(.retryAfter) {
        retryAfter = try container.decode(Int32?.self, forKey: .retryAfter)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.azureAsyncOperation != nil {try container.encode(azureAsyncOperation, forKey: .azureAsyncOperation)}
    if self.Location != nil {try container.encode(Location, forKey: .Location)}
    if self.retryAfter != nil {try container.encode(retryAfter, forKey: .retryAfter)}
  }
}
