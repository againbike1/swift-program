

import Foundation

let aNumber = 3
let aString = "Hello"
let aBool = true

let anArray = [1,2,3]
let aDictionary = ["key1": "value1", "key2": "value2"]

typealias ALC = ArrayLiteralConvertible
typealias BLC = BooleanLiteralConvertible
typealias DLC = DictionaryLiteralConvertible
typealias FLC = FloatLiteralConvertible
typealias NLC = NilLiteralConvertible
typealias ILC = IntegerLiteralConvertible
typealias SLC = StringLiteralConvertible

enum MyBool: Int {
    case myTrue, myFalse
}

extension MyBool: BooleanLiteralConvertible {
    init(booleanLiteral value: Bool) {
        self = value ? myTrue : myFalse
    }
}

let myTrue: MyBool = true
let myFalse: MyBool = false

myTrue.rawValue    // 0
myFalse.rawValue   // 1

//class Person {
//    let name: String
//    init(name value: String) {
//        self.name = value
//    }
//}

class Person: StringLiteralConvertible {
    let name: String
    init(name value: String) {
        self.name = value
    }
    
    required convenience init(stringLiteral value: String) {
        self.init(name: value)
    }
    
    required convenience init(extendedGraphemeClusterLiteral value: String) {
        self.init(name: value)
    }
    
    required convenience init(unicodeScalarLiteral value: String) {
        self.init(name: value)
    }
}

let p: Person = "xiaoMing"
print(p.name)