import Foundation
// ProductResultProtocol is
public protocol ProductResultProtocol : Codable {
     var values: [ProductProtocol?]? { get set }
     var nextLink: String? { get set }
}
