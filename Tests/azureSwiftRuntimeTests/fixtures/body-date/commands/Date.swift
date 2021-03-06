// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is regenerated.

// Date is the test Infrastructure for AutoRest
import Foundation
import azureSwiftRuntime
struct DateNamespace {
    // GetInvalidDate get invalid date value
    public class GetInvalidDateCommand : BaseCommand {

        public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/date/invaliddate"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let dataString = try decoder.decode(String?.self, from: data)
                return DateConverter.fromString(dateStr: dataString, format: .date)
            }
            
            throw DecodeError.unknownMimeType
        }
        
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Date?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result, error) in
                completionHandler(result, error)
            }
        }
    }

    // GetMaxDate get max date value 9999-12-31
    public class GetMaxDateCommand : BaseCommand {

        public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/date/max"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let dataString = try decoder.decode(String?.self, from: data)
                return DateConverter.fromString(dateStr: dataString, format: .date)
            }
            
            throw DecodeError.unknownMimeType
        }
        
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Date?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result, error) in
                completionHandler(result, error)
            }
        }
    }

    // GetMinDate get min date value 0000-01-01
    public class GetMinDateCommand : BaseCommand {

        public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/date/min"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let dataString = try decoder.decode(String?.self, from: data)
                return DateConverter.fromString(dateStr: dataString, format: .date)
            }
            
            throw DecodeError.unknownMimeType
        }
        
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Date?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result, error) in
                completionHandler(result, error)
            }
        }
    }

    // GetNull get null date value
    public class GetNullCommand : BaseCommand {

        public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/date/null"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
        }


        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let dataString = try decoder.decode(String?.self, from: data)
                return DateConverter.fromString(dateStr: dataString, format: .date)
            }
            
            throw DecodeError.unknownMimeType
        }
        
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Date?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result, error) in
                completionHandler(result, error)
            }
        }
    }

    // GetOverflowDate get overflow date value
    public class GetOverflowDateCommand : BaseCommand {

        public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/date/overflowdate"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let dataString = try decoder.decode(String?.self, from: data)
                return DateConverter.fromString(dateStr: dataString, format: .date)
            }
            
            throw DecodeError.unknownMimeType
        }
        
        public func execute(client: RuntimeClient, completionHandler: @escaping (Date?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result, error) in
                completionHandler(result, error)
            }
        }
    }

    // GetUnderflowDate get underflow date value
    public class GetUnderflowDateCommand : BaseCommand {

        public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/date/underflowdate"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let dataString = try decoder.decode(String?.self, from: data)
                return DateConverter.fromString(dateStr: dataString, format: .date)
            }
            
            throw DecodeError.unknownMimeType
        }
        
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Data?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result, error) in
                completionHandler(result, error)
            }
        }
    }

    // PutMaxDate put max date value 9999-12-31
    public class PutMaxDateCommand : BaseCommand {
        public var dateBody : Date?

        public override init() {
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/date/max"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.body = dateBody
        }

        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let dateBodyString = DateConverter.toString(date: dateBody, format: .date)
                let encodedValue = try encoder.encode(dateBodyString)
                return encodedValue
            }
            
            throw DecodeError.unknownMimeType
        }

        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                error in
                completionHandler(error)
            }
        }
    }

    // PutMinDate put min date value 0000-01-01
    public class PutMinDateCommand : BaseCommand {
        public var dateBody :  Date?

        public override init() {
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/date/min"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.body = dateBody
        }

        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let dateBodyString = DateConverter.toString(date: dateBody, format: .date)
                let encodedValue = try encoder.encode(dateBodyString)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                error in
                completionHandler(error)
            }
        }
    }
}
