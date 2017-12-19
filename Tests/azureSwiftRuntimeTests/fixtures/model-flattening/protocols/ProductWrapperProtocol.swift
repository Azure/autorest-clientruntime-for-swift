import Foundation
// ProductWrapperProtocol is the wrapped produc.
public protocol ProductWrapperProtocol : Codable {
     var property: WrappedProductProtocol? { get set }
}
