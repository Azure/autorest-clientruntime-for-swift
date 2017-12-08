import Foundation
public struct ErrorType : ErrorTypeProtocol {
    public var status: Int32?
    public var message: String?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.status) {
        status = try container.decode(Int32?.self, forKey: .status)
    }
    if container.contains(.message) {
        message = try container.decode(String?.self, forKey: .message)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.status != nil {try container.encode(status, forKey: .status)}
    if self.message != nil {try container.encode(message, forKey: .message)}
  }
}
