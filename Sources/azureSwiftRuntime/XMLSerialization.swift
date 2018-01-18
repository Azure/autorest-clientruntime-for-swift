//
//  XMLSerialization.swift
//  azureSwiftRuntime
//
//  Created by Vladimir Shcherbakov on 1/12/18.
//

import Foundation

open class XMLSerialization {
    public static func xmlObject(data: Data) throws -> Any {
        return try _XMLParser(xmlData: data).parseXML()
    }
}

fileprivate class Node {
    var children = [Node]()
    var value: Any = NSNull()
    var name: String
    
    init (name: String) {
        self.name = name
    }
    
    func printTree(level: Int = 0) {
        let tabs = String(repeating: "\t", count: level)
        print(tabs, name, value is NSNull ? "" : value)
        for child in children {
            child.printTree(level: level+1)
        }
    }
    
    func convertTree() throws -> (String, Any) {
        if children.isEmpty {
            return (name, value as Any)
        } else {
            var chPairList = [(String, Any)]()
            for child in children {
                let chPair = try child.convertTree()
                chPairList.append(chPair)
            }
            
            let mapOrArray = try buildMapOrArray(pairList: chPairList)
            return (name, mapOrArray)
        }
    }
    
    private func buildMapOrArray(pairList: [(String, Any)]) throws -> Any {
        if pairList.count == 1 {
            let (key, val) = pairList.first!
            return [key:val]
        }
        
        var testMap = [String:[Any]]()
        for pair in pairList {
            let (key, val) = pair
            if var values = testMap[key] {
                values.append(val)
                testMap[key] = values
            } else {
                testMap[key] = [val]
            }
        }
        
        switch testMap.count {
        case 1: // array
            let (_, values) = testMap.first!
            return values
        case pairList.count: // map
            var map = [String:Any]()
            for pair in pairList {
                let (key, val) = pair
                map[key] = val
            }
            
            return map
        default: // error
            throw XMLDecodingError.keyDuplicates
        }
    }
}

fileprivate struct Stack<T> {
    private var array: [T] = []
    
    mutating func push(_ element: T) {
        array.append(element)
    }
    
    mutating func pop() -> T? {
        return array.popLast()
    }
    
    func peek() -> T? {
        return array.last
    }
}

fileprivate class _XMLParser: NSObject, XMLParserDelegate {
    var parser: XMLParser
    
    var stack = Stack<Node>()
    
    //var dict: [String:Any]
    
    var errors = [Error]()
    
    var root = Node(name: "Root")
    
    init(xmlData: Data) {
        parser = XMLParser(data: xmlData)
        super.init()
        parser.delegate = self
    }
    
    func parseXML() throws -> Any {
        parser.parse()
        root.printTree()
        if !errors.isEmpty {
            throw errors.first!
        }
        
        let (_, val) = try root.convertTree()
        
        //return [key: val]
        return val
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        //print("-->", elementName)
        
        let newNode = Node(name: elementName)
        if !attributeDict.isEmpty {
            for (key, val) in attributeDict {
                let attrNode = Node(name: key)
                attrNode.value = val
                newNode.children.append(attrNode)
            }
        }
        if let node = stack.pop() {
            node.children.append(newNode)
            stack.push(node)
            stack.push(newNode)
        } else {
            root = newNode
            stack.push(root)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //print("<--", elementName)
        if let node = stack.pop() {
            if node.name != elementName {
                print("!!! Parser Error", "pop elem is not equal end elem" )
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //print("\t", string)
        if let node = stack.pop() {
            let val = (node.value is NSNull) ? "" : node.value as! String
            node.value = val + string.trimmingCharacters(in: .whitespacesAndNewlines)
            stack.push(node)
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("!!!", parseError)
        errors.append(parseError)
    }
}
