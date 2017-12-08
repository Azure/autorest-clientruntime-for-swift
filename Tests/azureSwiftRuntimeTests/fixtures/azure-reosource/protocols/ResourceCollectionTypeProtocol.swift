import Foundation
// ResourceCollectionTypeProtocol is
public protocol ResourceCollectionTypeProtocol : Codable {
     var productresource: FlattenedProductTypeProtocol? { get set }
     var arrayofresources: [FlattenedProductTypeProtocol?]? { get set }
     var dictionaryofresources: [String:FlattenedProductTypeProtocol?]? { get set }
}
