### Swift.Range family
### Swift4
2017/7/25  

ezura

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
(注: 全網羅していても `default` が必要)

+++

```swift
let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let asciiTable = zip(65..., alphabet) // Zip2Sequence
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

もう少し深堀してみよう😇

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
let greeting = s[..<i] // use `PartialRangeUpTo`

let withComma = s.prefix(through: i)
let withComma = s[...i] // use `PartialRangeThrough`

let location = s.suffix(from: i)
let location = s[i...] // use `PartialRangeFrom`
```

+++

#### CountablePartialRangeFrom
#### protocol RangeExpression

+++

### CountablePartialRangeFrom

```swift
let asciiTable = zip(65..., "ABCDEFGHIJKLMNOPQRSTUVWXYZ") // use `CountablePartialRangeFrom`
```

+++

```swift
struct CountablePartialRangeFrom : Sequence 
    where Bound : Strideable,
          Bound.Stride : SignedInteger { ... }
```

+++

* CountableRange (0..<5)
* CountableClosedRange (0...5)
仲間

+++

### RangeExpression

+++

Range への変換を備える

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

コレクション(Index == Bound)の文脈において、  
`..<i` は `collection.startIndex..<i`

<div>
<span class="special">他の種類の Range も Range 型に変換できる</span>
<span class="special">他の種類の Range も Range 型に変換できる</span>
</div> <!-- .element: class="fragment" -->

+++

`RangeExpression` のおかげで Range 型として

+++

