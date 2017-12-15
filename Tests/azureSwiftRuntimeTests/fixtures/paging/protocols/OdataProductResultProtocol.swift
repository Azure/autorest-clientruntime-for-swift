import Foundation
// OdataProductResultProtocol is
public protocol OdataProductResultProtocol : Codable {
     var values: [ProductProtocol?]? { get set }
     var odatanextLink: String? { get set }
}
