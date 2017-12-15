import Foundation
public struct OdataProductResultData : OdataProductResultProtocol {
    public var values: [ProductProtocol?]?
    public var odatanextLink: String?

    enum CodingKeys: String, CodingKey {
        case values = "values"
        case odatanextLink = "odata.nextLink"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.values) {
        values = try container.decode([ProductData?]?.self, forKey: .values)
    }
    if container.contains(.odatanextLink) {
        odatanextLink = try container.decode(String?.self, forKey: .odatanextLink)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.values != nil {try container.encode(values as! [ProductData?]?, forKey: .values)}
    if self.odatanextLink != nil {try container.encode(odatanextLink, forKey: .odatanextLink)}
  }
}
