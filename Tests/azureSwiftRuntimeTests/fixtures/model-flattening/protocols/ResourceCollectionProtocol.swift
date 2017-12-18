import Foundation
// ResourceCollectionProtocol is
public protocol ResourceCollectionProtocol : Codable {
     var productresource: FlattenedProductProtocol? { get set }
     var arrayofresources: [FlattenedProductProtocol?]? { get set }
     var dictionaryofresources: [String:FlattenedProductProtocol?]? { get set }
}
