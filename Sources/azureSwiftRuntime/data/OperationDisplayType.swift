import Foundation
public struct OperationDisplayType : OperationDisplayTypeProtocol {
    public var provider: String?
    public var resource: String?
    public var operation: String?

    enum CodingKeys: String, CodingKey {
        case provider = "provider"
        case resource = "resource"
        case operation = "operation"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    provider = try container.decode(String?.self, forKey: .provider)
    resource = try container.decode(String?.self, forKey: .resource)
    operation = try container.decode(String?.self, forKey: .operation)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(provider, forKey: .provider)
    try container.encode(resource, forKey: .resource)
    try container.encode(operation, forKey: .operation)
  }
}