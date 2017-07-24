### Swift.Range family
### Swift4
2017/7/25  

ezura

note: こんにちは

---

### "\\(self)"
* ezura
* iOS engineer @ LINE
* twitter: ezura (@eduraaa)

<div style="text-align:">
![icon](assets/images/acount_image_c.png)
</div>

---

### Range

---?image=assets/images/lake.jpg
### <span style="text-shadow: #000 1px 1px 0; color:white;">あなたが思い浮かべた `Range` は</span>
#### <span style="color:white;">Range?</span> <!-- .element: class="fragment" -->
#### <span style="color:white;">ClosedRange?</span> <!-- .element: class="fragment" -->
#### <span style="color:white;">CountableRange?</span> <!-- .element: class="fragment" -->
#### <span style="color:white;">CountableClosedRange?</span> <!-- .element: class="fragment" -->

+++

### Swift3 Ranges
* Range (0..<5.0)
* ClosedRange ("a"..."z")
* CountableRange (0..<5)
* CountableClosedRange (0...5)

+++

### Swift2 Ranges
* Range (0..<5, 0...5)
* ClosedInterval ("a"..."z")
* HalfOpenInterval (0..<5.0)

---

### Swift4 new Ranges!
</br>
### <span><span class="special">One-sided Ranges</span></span> <!-- .element: class="fragment" -->

+++

## What is One-sided Ranges?
<div>
* 5.0...
* ..<5.0
* ...5.0
* 5...
</div> <!-- .element: class="fragment" -->

+++

### Swift4
* Range (0..<5.0)
* ClosedRange (0...5.0)
* CountableRange (0..<5)
* CountableClosedRange (0...5)
* <span class="special">PartialRangeFrom (5.0...)</span>
* <span class="special">PartialRangeUpTo (..<5.0)</span>
* <span class="special">PartialRangeThrough (...5.0)</span>
* <span class="special">CountablePartialRangeFrom (5...)</span>
* <span class="special">protocol RangeExpression</span>

+++

今までと違い、  
One-sided Ranges (+ protocol) の純粋な追加 😊

+++

### 何が便利になるの？

+++

### Motivation
書きやすさ・可読性の向上

+++

```swift
let s = "Hello, World!"
let i = s.index(of: ",")!

let greeting = s[s.startIndex..<i]   // "Hello"
let _greeting = s.prefix(upTo: i)    // "Hello"

let withComma = s.prefix(through: i) // "Hello,"

let location = s.suffix(from: i)     // ", World!"
```
@[4-5]
@[7]
@[9]

現状

+++

```swift
let greeting = s[..<i]  // "Hello"

let withComma = s[...i] // "Hello,"

let location = s[i...] // ", World!"
```

<div>
```swift
let greeting = s[s.startIndex..<i]   // "Hello"
let _greeting = s.prefix(upTo: i)    // "Hello"

let withComma = s.prefix(through: i) // "Hello,"

let location = s.suffix(from: i)     // ", World!"
```
</div> <!-- .element: class="fragment" -->

+++

```swift
let array = ["ジャンプ", "サンデー", "ガンガン", "花とゆめ", "なかよし"]
array[..<3] // ["ジャンプ", "サンデー", "ガンガン"]
array[...2] // ["ジャンプ", "サンデー", "ガンガン"]
array[3...] // ["花とゆめ", "なかよし"]
```

+++

```swift
switch "a" {
case ..<"c": // ...
case "c"...: // ...
default: // ...
}
```
(注: 全網羅していても `default` が必要) <!-- .element: class="fragment" -->

+++

```swift
let asciiTable = zip(65..., "ABCDEFGHIJKLMNOPQRSTUVWXYZ")

asciiTable.forEach { print($0) }
/*
(65, "A")
(66, "B")
...
(89, "Y")
(90, "Z")
*/
```

---

もう少し深堀りしてみよう😇

+++

### Swift4
* Range (0..<5.0)
* ClosedRange ("a"..."z")
* CountableRange (0..<5)
* CountableClosedRange (0...5)
* <span class="special">PartialRangeFrom (5.0...)</span>
* <span class="special">PartialRangeUpTo (..<5.0)</span>
* <span class="special">PartialRangeThrough (...5.0)</span>
* <span class="special">CountablePartialRangeFrom (5...)</span>
* <span class="special">protocol RangeExpression</span>

+++

増えたのは型が 4 つと protocol？

+++

```swift
let greeting = s.prefix(upTo: i)
// use `PartialRangeUpTo`
let greeting = s[..<i]

let withComma = s.prefix(through: i)
// use `PartialRangeThrough`
let withComma = s[...i]

let location = s.suffix(from: i)
// use `PartialRangeFrom`
let location = s[i...]
```

+++

#### `CountablePartialRangeFrom`
#### `protocol RangeExpression`

+++

### `CountablePartialRangeFrom`

```swift
// use `CountablePartialRangeFrom`
let asciiTable = zip(65..., "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
```

+++

```swift
struct CountablePartialRangeFrom : Sequence 
    where Bound : Strideable,
          Bound.Stride : SignedInteger { ... }
```

+++

* `CountableRange` (0..<5)
* `CountableClosedRange` (0...5)
仲間

+++

### `RangeExpression`

+++

Range 型への変換を備える

```swift
public protocol RangeExpression {
    associatedtype Bound : Comparable
    public func relative<C>(to collection: C) -> Range<Self.Bound> where C : _Indexable, Self.Bound == C.Index
    public func contains(_ element: Self.Bound) -> Bool
}

extension RangeExpression {
    public static func ~=(pattern: Self, value: Self.Bound) -> Bool
}
```
@[3]

+++

<div class="special">
コレクション(*Range.Bound == Collection.Index)の  
文脈において、*Range は Range 型に変換可能 =
"Range 型" として統一的に扱える
</div>

<div>

```swift
s[..<i]
s[s.startIndex..<i]

s[i...]
s[i..<s.endIndex]

// 残りは https://github.com/ezura/swift/blob/73ba66abe11486401375c7f8f67352f3e7d6c529/stdlib/public/core/Range.swift.gyb#L541-L552
// https://github.com/apple/swift/blob/0e70dced60837bf7ade24d08ef9c5b459f9ec4f6/stdlib/public/core/Range.swift.gyb#L807
// 参照
```

</div> <!-- .element: class="fragment" -->

---

### まとめ

* One-sided Ranges が追加
* 既存のコードに影響なし
* 複雑化したように見えて、整理すると簡単

---

### 参考

* [apple/swift-evolution/proposals/0172-one-sided-ranges.md](https://github.com/apple/swift-evolution/blob/master/proposals/0172-one-sided-ranges.md)
* [[stdlib] One-sided ranges and RangeExpression](https://github.com/apple/swift/pull/8710/files)
* [apple/swift/docs/StringManifesto.md String Processing For Swift 4](https://github.com/apple/swift/blob/master/docs/StringManifesto.md#unification-of-slicing-operations)
* [Swift 3のRange徹底解説](http://qiita.com/mono0926/items/88779ceff30f8fc705c5)
* [What’s New in Swift 4?](https://www.raywenderlich.com/163857/whats-new-swift-4)
