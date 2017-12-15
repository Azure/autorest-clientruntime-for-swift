import Foundation
// OperationResultProtocol is
public protocol OperationResultProtocol : Codable {
     var status: Status? { get set }
}
