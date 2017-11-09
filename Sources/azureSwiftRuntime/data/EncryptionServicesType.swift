import Foundation
public struct EncryptionServicesType : EncryptionServicesTypeProtocol {
    public var blob: EncryptionServiceTypeProtocol?
    public var file: EncryptionServiceTypeProtocol?
    public var table: EncryptionServiceTypeProtocol?
    public var queue: EncryptionServiceTypeProtocol?

    enum CodingKeys: String, CodingKey {
        case blob = "blob"
        case file = "file"
        case table = "table"
        case queue = "queue"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    blob = try container.decode(EncryptionServiceType?.self, forKey: .blob)
    file = try container.decode(EncryptionServiceType?.self, forKey: .file)
    table = try container.decode(EncryptionServiceType?.self, forKey: .table)
    queue = try container.decode(EncryptionServiceType?.self, forKey: .queue)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(blob as! EncryptionServiceType?, forKey: .blob)
    try container.encode(file as! EncryptionServiceType?, forKey: .file)
    try container.encode(table as! EncryptionServiceType?, forKey: .table)
    try container.encode(queue as! EncryptionServiceType?, forKey: .queue)
  }
}
