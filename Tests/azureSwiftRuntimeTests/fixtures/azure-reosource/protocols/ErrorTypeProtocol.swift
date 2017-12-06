import Foundation
// ErrorTypeProtocol is
public protocol ErrorTypeProtocol : Codable {
     var status: Int32? { get set }
     var message: String? { get set }
}
