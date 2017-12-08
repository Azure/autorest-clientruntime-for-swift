import Foundation
// OperationResultTypeProtocol is
public protocol OperationResultTypeProtocol : Codable {
     var status: Status? { get set }
     var error: OperationResultErrorTypeProtocol? { get set }
}
