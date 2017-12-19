import Foundation
public struct ErrorData : ErrorProtocol {
    public var status: Int32?
    public var message: String?
    public var parentError: ErrorProtocol?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case parentError = "parentError"
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
    if container.contains(.parentError) {
        parentError = try container.decode(ErrorData?.self, forKey: .parentError)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.status != nil {try container.encode(status, forKey: .status)}
    if self.message != nil {try container.encode(message, forKey: .message)}
    if self.parentError != nil {try container.encode(parentError as! ErrorData?, forKey: .parentError)}
  }
}
