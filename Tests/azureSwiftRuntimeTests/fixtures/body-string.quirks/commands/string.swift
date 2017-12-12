// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is regenerated.

// String is the test Infrastructure for AutoRest Swagger BAT
import Foundation
import azureSwiftRuntime


struct StringNamespace {
    // GetBase64Encoded get value that is base64 encoded
    public class GetBase64EncodedCommand : BaseCommand {
        public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/string/base64Encoding"
        }

        public override func preCall()  {
        }

        override func returnFunc(data: Data) throws -> Decodable? {
            return try JsonResponseDecoder.decode(String?.self, from: data)
        }
        
        public func execute(client: RuntimeClient) throws -> String? {
            return try client.execute(command: self) as! String?
        }
    }

    // GetBase64UrlEncoded get value that is base64url encoded
    public class GetBase64UrlEncodedCommand : BaseCommand {

        public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/string/base64UrlEncoding"
        }

        public override func preCall()  {
        }


        override func returnFunc(data: Data) throws -> Decodable? {
            return try JsonResponseDecoder.decode(String?.self, from: data)
        }
        
        public func execute(client: RuntimeClient) throws -> String? {
            return try client.execute(command: self) as! String?
        }
    }

    // GetEmpty get empty string value value ''
    public class GetEmptyCommand : BaseCommand {
        public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/string/empty"
        }

        public override func preCall()  {
        }

        override func returnFunc(data: Data) throws -> Decodable? {
            return try JsonResponseDecoder.decode(String?.self, from: data)
        }
        
        public func execute(client: RuntimeClient) throws -> String? {
            return try client.execute(command: self) as! String?
        }
    }
    
    // GetMbcs get mbcs string value '啊齄丂狛狜隣郎隣兀﨩ˊ〞〡￤℡㈱‐ー﹡﹢﹫、〓ⅰⅹ⒈€㈠㈩ⅠⅫ！￣ぁんァヶΑ︴АЯаяāɡㄅㄩ─╋︵﹄︻︱︳︴ⅰⅹɑɡ〇〾⿻⺁䜣€'
    public class GetMbcsCommand : BaseCommand {

        public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/string/mbcs"
        }

        public override func preCall() {
        }
        
        override func returnFunc(data: Data) throws -> Decodable? {
            return try JsonResponseDecoder.decode(String?.self, from: data)
        }
        
        public func execute(client: RuntimeClient) throws -> String? {
            return try client.execute(command: self) as! String?
        }
    }

    // GetNotProvided get String value when no string value is sent in response payload
    public class GetNotProvidedCommand : BaseCommand {
        
        public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/string/notProvided"
        }

        public override func preCall()  {
        }

        override func returnFunc(data: Data) throws -> Decodable? {
            return try JsonResponseDecoder.decode(String?.self, from: data)
        }
        
        public func execute(client: RuntimeClient) throws -> String? {
            return try client.execute(command: self) as! String?
        }
    }

    // GetNull get null string value value
    public class GetNullCommand : BaseCommand {

        public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/string/null"
        }

        public override func preCall()  {
        }

        override func returnFunc(data: Data) throws -> Decodable? {
            return try JsonResponseDecoder.decode(String?.self, from: data)
        }
        
        public func execute(client: RuntimeClient) throws -> String? {
            return try client.execute(command: self) as! String?
        }
    }

    // GetNullBase64UrlEncoded get null value that is expected to be base64url encoded
    public class GetNullBase64UrlEncodedCommand : BaseCommand {

        public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/string/nullBase64UrlEncoding"
        }

        public override func preCall()  {
        }

        override func returnFunc(data: Data) throws -> Decodable? {
            return try JsonResponseDecoder.decode(String?.self, from: data)
        }
        
        public func execute(client: RuntimeClient) throws -> String? {
            return try client.execute(command: self) as! String?
        }
    }

    // GetWhitespace get string value with leading and trailing whitespace '<tab><space><space>Now is the time for all good
    // men to come to the aid of their country<tab><space><space>'
    public class GetWhitespaceCommand : BaseCommand {

        public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/string/whitespace"
        }

        public override func preCall()  {
        }

        override func returnFunc(data: Data) throws -> Decodable? {
            return try JsonResponseDecoder.decode(String?.self, from: data)
        }
        
        public func execute(client: RuntimeClient) throws -> String? {
            return try client.execute(command: self) as! String?
        }
    }

    // PutBase64UrlEncoded put value that is base64url encoded
    public class PutBase64UrlEncodedCommand : BaseCommand {
        public var stringBody :  String?

        public override init() {
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/string/base64UrlEncoding"
            self.headerParameters = ["Content-Type":"application/json"]
        }

        public override func preCall()  {
            self.body = stringBody
        }

        public override func encodeBody() throws -> Data? {
            return try JsonRequestEncoder.encode(encodable: stringBody)
        }

        public func execute(client: RuntimeClient) throws -> Decodable? {
            return try client.execute(command: self)
        }
    }

    // PutEmpty set string value empty ''
    public class PutEmptyCommand : BaseCommand {
        public var stringBody :  String?

       public override init() {
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/string/empty"
            self.headerParameters = ["Content-Type":"application/json"]
        }

        public override func preCall()  {
            self.body = stringBody
        }

        public override func encodeBody() throws -> Data? {
            return try JsonRequestEncoder.encode(encodable: stringBody)
        }

        public func execute(client: RuntimeClient) throws -> Decodable? {
            return try client.execute(command: self)
        }
    }

    // PutMbcs set string value mbcs '啊齄丂狛狜隣郎隣兀﨩ˊ〞〡￤℡㈱‐ー﹡﹢﹫、〓ⅰⅹ⒈€㈠㈩ⅠⅫ！￣ぁんァヶΑ︴АЯаяāɡㄅㄩ─╋︵﹄︻︱︳︴ⅰⅹɑɡ〇〾⿻⺁䜣€'
    public class PutMbcsCommand : BaseCommand {
        public var stringBody :  String?

        public override init() {
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/string/mbcs"
            self.headerParameters = ["Content-Type":"application/json"]
        }

        public override func preCall()  {
            self.body = stringBody
        }

        public override func encodeBody() throws -> Data? {
            return try JsonRequestEncoder.encode(encodable: stringBody)
        }

        public func execute(client: RuntimeClient) throws -> Decodable? {
            return try client.execute(command: self)
        }
    }

    // PutNull set string value null
    public class PutNullCommand : BaseCommand {
        public var stringBody :  String?
        
        public override init() {
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/string/null"
        }

        public override func preCall()  {
            self.body = stringBody
        }

        public override func encodeBody() throws -> Data? {
            return try JsonRequestEncoder.encode(encodable: stringBody)
        }

        public func execute(client: RuntimeClient) throws -> Decodable? {
            return try client.execute(command: self)
        }
    }

    // PutWhitespace set String value with leading and trailing whitespace '<tab><space><space>Now is the time for all good
    // men to come to the aid of their country<tab><space><space>'
    public class PutWhitespaceCommand : BaseCommand {
        public var stringBody :  String?
        
        public override init() {
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/string/whitespace"
            self.headerParameters = ["Content-Type":"application/json"]
        }

        public override func preCall()  {
            self.body = stringBody
        }

        public override func encodeBody() throws -> Data? {
            return try JsonRequestEncoder.encode(encodable: stringBody)
        }

        public func execute(client: RuntimeClient) throws -> Decodable? {
            return try client.execute(command: self)
        }
    }

}
