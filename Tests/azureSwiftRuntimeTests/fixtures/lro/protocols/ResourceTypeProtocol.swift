import Foundation
// ResourceTypeProtocol is some resource
public protocol ResourceTypeProtocol : Codable {
     var id: String? { get set }
     var type: String? { get set }
     var tags: [String:String?]? { get set }
     var location: String? { get set }
     var name: String? { get set }
}
