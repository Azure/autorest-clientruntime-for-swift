import Foundation
public struct OperationResultType : OperationResultTypeProtocol {
    public var status: Status?
    public var error: OperationResultErrorTypeProtocol?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case error = "error"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.status) {
        status = try container.decode(Status?.self, forKey: .status)
    }
    if container.contains(.error) {
        error = try container.decode(OperationResultErrorType?.self, forKey: .error)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.status != nil {try container.encode(status, forKey: .status)}
    if self.error != nil {try container.encode(error as! OperationResultErrorType?, forKey: .error)}
  }
}
