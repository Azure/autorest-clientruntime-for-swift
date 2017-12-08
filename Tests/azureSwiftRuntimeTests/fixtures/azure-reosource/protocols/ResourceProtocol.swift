import Foundation
// ResourceProtocol is some resource
public protocol ResourceProtocol : Codable {
     var id: String? { get set }
     var type: String? { get set }
     var tags: [String:String?]? { get set }
     var location: String? { get set }
     var name: String? { get set }
}
