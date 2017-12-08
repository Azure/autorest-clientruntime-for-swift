import Foundation
// CloudErrorTypeProtocol is
public protocol CloudErrorTypeProtocol : Codable {
     var status: Int32? { get set }
     var message: String? { get set }
}
