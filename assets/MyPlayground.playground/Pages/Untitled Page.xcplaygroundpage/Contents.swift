//: Playground - noun: a place where people can play

import UIKit

let text = "long long long long long text"
let prefix10 = text.utf8
let range = 1...


func testslice(_ s: Array<Int>) {
    for i in 0..<s.count { print(s[i]+1) }
    for i in s { print(i+1) }
    _ = s[0..<2]
    _ = s[0...1]
    _ = s[...1]
    _ = s[1...]
    _ = s[..<2]
}

let charRangeFromA = Character("b")...
let charRangeToZ = ...Character("z")

charRangeFromA.contains("a")

testslice([1, 2, 3])

enum Week {
    case sun
    case mon
    case tues
    case wed
    case thurs
    case sata
}

let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let asciiTable = zip(65..., "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
asciiTable.forEach { print($0) }

let table = zip(1...,
                ["🍎", "🍇", "🍐", "🍓"])
table.forEach { print($0) }
/*
 (1, "🍎")
 (2, "🍇")
 (3, "🍐")
 (4, "🍓")
 */

for (code, letter) in asciiTable {
    print(code, letter)
}

extension Week: Sequence, IteratorProtocol {
    func next() -> Week? {
        switch self {
        case .sun: return .mon
        case .mon: return .tues
        case .tues: return .wed
        case .wed: return .thurs
        case .thurs: return .sata
        case .sata: return .sun
        }
    }
}

extension Week: Comparable {
    static func <(lhs: Week, rhs: Week) -> Bool { return true }
    static func >(lhs: Week, rhs: Week) -> Bool { return true }
}

let a = "aaaaaa"

struct A<T> {
    struct B {}
}

//type(of: A.B.self)

func type<T>(of: T) -> T.Type { fatalError() }
//type(of: Int.self)

//protocol `Any` {}
//struct A {
//    func f()
//}
//
//struct B {
//    func f()
//}

//A.B()

