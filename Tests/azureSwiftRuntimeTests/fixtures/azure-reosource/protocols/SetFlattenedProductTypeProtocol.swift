import Foundation
// SetFlattenedProductTypeProtocol is
public protocol SetFlattenedProductTypeProtocol : Codable {
     var value: [String:FlattenedProductTypeProtocol?]? { get set }
}
