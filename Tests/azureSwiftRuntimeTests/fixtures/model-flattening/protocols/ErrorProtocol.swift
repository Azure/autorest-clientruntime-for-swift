import Foundation
// ErrorProtocol is
public protocol ErrorProtocol : Codable {
     var status: Int32? { get set }
     var message: String? { get set }
     var parentError: ErrorProtocol? { get set }
}
