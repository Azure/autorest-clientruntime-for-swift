import Foundation
public struct OperationResultData : OperationResultProtocol {
    public var status: Status?

    enum CodingKeys: String, CodingKey {
        case status = "status"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.status) {
        status = try container.decode(Status?.self, forKey: .status)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.status != nil {try container.encode(status, forKey: .status)}
  }
}
