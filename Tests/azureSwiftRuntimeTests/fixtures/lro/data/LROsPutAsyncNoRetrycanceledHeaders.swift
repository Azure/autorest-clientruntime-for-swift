import Foundation
public struct LROsPutAsyncNoRetrycanceledHeaders : LROsPutAsyncNoRetrycanceledHeadersProtocol {
    public var azureAsyncOperation: String?
    public var Location: String?

    enum CodingKeys: String, CodingKey {
        case azureAsyncOperation = "Azure-AsyncOperation"
        case Location = "Location"
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
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.azureAsyncOperation != nil {try container.encode(azureAsyncOperation, forKey: .azureAsyncOperation)}
    if self.Location != nil {try container.encode(Location, forKey: .Location)}
  }
}
