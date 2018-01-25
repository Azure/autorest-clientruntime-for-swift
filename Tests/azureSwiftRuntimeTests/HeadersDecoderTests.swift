//
//  MapDecoderTests.swift
//  azureSwiftRuntime
//
//  Created by Vladimir Shcherbakov on 1/25/18.
//

import Foundation
import XCTest
import azureSwiftRuntime

struct BlobProperties {
    let contentLength : Int
    let xMsServerEncrypted : Bool
    let eTag : String
    let lastModified : Date
    let contentType : String
    let date : Date
}

extension BlobProperties: Decodable {
    enum CodingKeys: String, CodingKey {
        case contentLength = "Content-Length"
        case xMsServerEncrypted = "x-ms-server-encrypted"
        case eTag = "Etag"
        case lastModified = "Last-Modified"
        case contentType = "Content-Type"
        case date = "Date"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        contentLength = try container.decode(Int.self, forKey: .contentLength)
        xMsServerEncrypted = try container.decode(Bool.self, forKey: .xMsServerEncrypted)
        eTag = try container.decode(String.self, forKey: .eTag)
        lastModified = try container.decode(Date.self, forKey: .lastModified)
        contentType = try container.decode(String.self, forKey: .contentType)
        date = try container.decode(Date.self, forKey: .date)
    }
}

class MapDecoderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSipmleMap() {
        
        let headers : [String:String] = [
            "Content-Length" : "268435456",
            "x-ms-server-encrypted" : "true",
            "x-ms-lease-state" : "available",
            "x-ms-version" : "2016-05-31",
            "x-ms-lease-status" : "unlocked",
            "Etag" : "0x8D561E6EBD0E456",
            "Last-Modified" : "Mon, 22 Jan 2018 22:24:36 GMT",
            "content-md5" : "6Uf8YrARuOM/5ckfn4VyFw==",
            "Accept-Ranges" : "bytes",
            "x-ms-request-id" : "2a982512-001e-0015-0502-960db2000000",
            "Content-Type" : "application/xml; charset=utf-8",
            "Server" : "Windows-Azure-Blob/1.0 Microsoft-HTTPAPI/2.0",
            "x-ms-blob-type" : "BlockBlob",
            "Date" : "Thu, 25 Jan 2018 17:30:01 GMT",
        ]
        
        let decoder = HeadersDecoder()
        
        do {
            let blobProperties = try decoder.decode(BlobProperties.self, from: headers)
            XCTAssertEqual (blobProperties.contentLength, 268435456)
            XCTAssertEqual (blobProperties.xMsServerEncrypted, true)
            XCTAssertEqual (blobProperties.contentType, "application/xml; charset=utf-8")
        } catch {
            print ("=== Error:", error)
            XCTFail(error.localizedDescription)
        }
    }
}
