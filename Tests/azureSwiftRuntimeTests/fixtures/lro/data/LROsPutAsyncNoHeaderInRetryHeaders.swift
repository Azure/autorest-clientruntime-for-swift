import Foundation
public struct LROsPutAsyncNoHeaderInRetryHeaders : LROsPutAsyncNoHeaderInRetryHeadersProtocol {
    public var azureAsyncOperation: String?

    enum CodingKeys: String, CodingKey {
        case azureAsyncOperation = "Azure-AsyncOperation"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.azureAsyncOperation) {
        azureAsyncOperation = try container.decode(String?.self, forKey: .azureAsyncOperation)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.azureAsyncOperation != nil {try container.encode(azureAsyncOperation, forKey: .azureAsyncOperation)}
  }
}
