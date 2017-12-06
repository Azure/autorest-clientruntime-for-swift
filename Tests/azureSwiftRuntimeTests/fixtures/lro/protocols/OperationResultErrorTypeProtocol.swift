import Foundation
// OperationResultErrorTypeProtocol is
public protocol OperationResultErrorTypeProtocol : Codable {
     var code: Int32? { get set }
     var message: String? { get set }
}
