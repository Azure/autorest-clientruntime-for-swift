import Foundation
public struct OperationResultErrorType : OperationResultErrorTypeProtocol {
    public var code: Int32?
    public var message: String?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case message = "message"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.code) {
        code = try container.decode(Int32?.self, forKey: .code)
    }
    if container.contains(.message) {
        message = try container.decode(String?.self, forKey: .message)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.code != nil {try container.encode(code, forKey: .code)}
    if self.message != nil {try container.encode(message, forKey: .message)}
  }
}
