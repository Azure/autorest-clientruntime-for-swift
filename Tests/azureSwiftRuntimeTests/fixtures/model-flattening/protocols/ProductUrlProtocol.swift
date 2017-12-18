import Foundation
// ProductUrlProtocol is the product URL.
public protocol ProductUrlProtocol : Codable {
     var genericValue: String? { get set }
     var odatavalue: String? { get set }
}
