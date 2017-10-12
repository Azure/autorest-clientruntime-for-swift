import XCTest
import RxSwift
import RxBlocking
import SwiftyJSON
@testable import azureSwiftRuntime

class azureSwiftRuntimeTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let myName = "swiftResourceGroup4"
        guard let restFactory = try? RestfulFactory() else {
            return;
        }
        
        try! restFactory.connect().toBlocking().first()
        
        let restGet = restFactory.getCall(
            verb: .Get(url: "\(restFactory.baseURL)subscriptions/\(restFactory.subcriptionId)/resourcegroups?api-version=2016-06-01"))
        let obs = restGet.call()
        guard let allResource = try! obs.toBlocking().first() else {
            return
        }
        
        if let resourcesArray = allResource!["value"].array {
            var resource = resourcesArray[0]
            let id = resource["id"].string!
            let name = resource["name"].string!
            let index = id.endIndex
            let sIndex = id.index(id.startIndex, offsetBy: 1)
            let idPart = String(describing: id[sIndex..<index])
            let restGet1 = restFactory.getCall(
                verb: .Get(url: "\(restFactory.baseURL)\(idPart)?api-version=2016-06-01"))
            let obs2 = restGet1.call()
            guard let myResource = try! obs2.toBlocking().first() else {
                return
            }
            
            print(myResource as Any)
            let newId = idPart.replacingOccurrences(of: name, with: myName)
            var newResourceGroup = [String: Any]()
            newResourceGroup["name"] = myName;
            newResourceGroup["location"] = "westus"
            
            let restPut = restFactory.getCall(
                verb: .Put(url: "\(restFactory.baseURL)\(newId)?api-version=2016-06-01", data: newResourceGroup))
            let obs = restPut.call()
            guard let madeResource = try! obs.toBlocking().first() else {
                return
            }

            print(madeResource as Any);
            let exportTemplateResource = ["resources": ["*"]]
            let restPost = restFactory.getCall(
                verb: .Post(url: "\(restFactory.baseURL)\(newId)/exportTemplate?api-version=2016-09-01", data: exportTemplateResource))
            let postObs = restPost.call()
            guard let postResource = try! postObs.toBlocking().first() else {
                return
            }

            print(postResource as Any);
            let restDelete = restFactory.getCall(
                verb: .Delete(url: "\(restFactory.baseURL)\(newId)?api-version=2016-06-01"))
            let deleteObs = restDelete.call()
            guard let deleteResource = try? deleteObs.toBlocking().first() else {
                return
            }

            print("Deleted");
        }
        
        //XCTAssertEqual(azureSwiftRuntime().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
