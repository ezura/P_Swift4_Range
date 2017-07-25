//: [Previous](@previous)

import Foundation
func f() -> Void {
    while true {}
}



//: [Next](@next)
//prefix func ..< <T>(v: T) -> PartialRangeUpTo<T> {
//    fatalError()
//}
//
//static func +(lhs: BinaryInteger, rhs: BinaryInteger) -> BinaryInteger {
//    return 1
//}

let array = ["ジャンプ", "サンデー", "ガンガン", "花とゆめ", "なかよし"]
array[..<3] // ["ジャンプ", "サンデー", "ガンガン"]
array[...2] // ["ジャンプ", "サンデー", "ガンガン"]
array[3...] // ["花とゆめ", "なかよし"]

switch "a" {
case ..<"c": print(#line)
case "c"...: print(#line)
default: print(#line)
}
//let v: CountablePartialRangeFrom = 5.0...
//CountablePartialRangeFrom
let s = "Hello, World!"
let _i = s.index(of: "e")!
let i = s.index(of: ",")!

do {
let greeting = s.prefix(upTo: i)
let withComma = s.prefix(through: i)
let location = s.suffix(from: i)
}

..<i
...i
i...

1...
...1

/*
 error: Execution was interrupted, reason: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0).
 The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.
 */
//((Int.max-2)...).forEach { print($0) }

do {
// half-open right-handed range
let greeting = s[..<i]
    s[s.startIndex..<i]
// closed right-handed range

let withComma = s[s.startIndex...i]
// left-handed range (no need for half-open variant)
let location = s[i...]
}

do {
    let array = [0, 1, 2, 3, 4, 5]
    array[0...]
    array[0..<array.endIndex]
    
    (_i...i)
    (_i...i).relative(to: s) // Range(0..<2)
    
    ...i
    (...i).relative(to: s) // Range(0..<2)
}
