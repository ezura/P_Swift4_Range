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

note: Range の話をします。

---?image=assets/images/lake.jpg
### <span style="text-shadow: #000 1px 1px 0; color:white;">あなたが思い浮かべた `Range` は</span>
#### <span style="color:white;">Range?</span> <!-- .element: class="fragment" -->
#### <span style="color:white;">ClosedRange?</span> <!-- .element: class="fragment" -->
#### <span style="color:white;">CountableRange?</span> <!-- .element: class="fragment" -->
#### <span style="color:white;">CountableClosedRange?</span> <!-- .element: class="fragment" -->

note: あなたが思い浮かべた Range は、Range 型ですか？  
ClosedRange 型ですか？  
CountableRange 型ですか？  
CountableClosedRange 型ですか？  

+++

### Swift3 Ranges
* Range (0..<5.0)
* ClosedRange ("a"..."z")
* CountableRange (0..<5)
* CountableClosedRange (0...5)

note:
Swift3 の Range は 4 つありますよね。

おさらいしておきますと、Countable つきとそうでない Range の違いは、Countable だと、Int 刻みでその次の値を表現できる空間の範囲を表します。1 の次は 2 とか。  
そうじゃないもの、例えば、double 型だと、0 の次の値がわかりません。0.01 刻みでも、0.001 刻みでも表現できませんよね。他にも文字や、文字列のインデックスもこれに当てはまります。
詳しく知りたい人は分かりやすい記事があるので、最後のスライドにリンクを載せておきます。

+++

### Swift2 Ranges
* Range (0..<5, 0...5)
* ClosedInterval ("a"..."z")
* HalfOpenInterval (0..<5.0)

note:
Swift2 ではこの 3 つで、かなりシンプル。
しかし、問題があって、Swift3 になって、設計が変わりました。

---

### Swift4 new Ranges!
</br>
### <span><span class="special">One-sided Ranges</span></span> <!-- .element: class="fragment" -->

note:
そして、Swift4
新しい Range の登場です
One-sided Ranges です。

+++

## What is One-sided Ranges?
<div>
* 5.0...
* ..<5.0
* ...5.0
* 5...
</div> <!-- .element: class="fragment" -->

note:
One-sided Ranges というのが何かというと、
片方の範囲だけ指定する Range です。
ということで、

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

note:
Swift4 ではこうなりました。
4 つの型と、1 つの protocol が増えました。

+++

Swift2 から Swift3 への変更と違い、  
One-sided Ranges (+ protocol) の純粋な追加 😊

note:
ただ、今回はそれほど大きな変更ではなくて、
表面的には One-sided Ranges が追加されるだけです

+++

### 何が便利になるの？

note:
なぜこれが増えたのかと言うと

+++

### Motivation
書きやすさ・可読性の向上

note:
書きやすさ・可読性の向上です

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

note:
文字列のスライスするときにすごく書きにくいですよね。  
任意の場所の前までスライスするとき。//  
任意の場所までスライスするとき。//  
任意の場所から最後までスライスするとき。//  

+++

```swift
let greeting = s[s.startIndex..<i]   // "Hello"
let _greeting = s.prefix(upTo: i)    // "Hello"

let withComma = s.prefix(through: i) // "Hello,"

let location = s.suffix(from: i)     // ", World!"
```

<div>
```swift
let greeting = s[..<i]  // "Hello"

let withComma = s[...i] // "Hello,"

let location = s[i...] // ", World!"
```
</div> <!-- .element: class="fragment" -->

note:
これが、
**
こうなります。
また、文字列操作だけじゃなくて

+++

```swift
let array = ["ジャンプ", "サンデー", "ガンガン", "花とゆめ", "なかよし"]
array[..<3] // ["ジャンプ", "サンデー", "ガンガン"]
array[...2] // ["ジャンプ", "サンデー", "ガンガン"]
array[3...] // ["花とゆめ", "なかよし"]
```

note:
Array などの Collection の範囲指定で使えたり

+++

```swift
switch "a" {
case ..<"c": // ...
case "c"...: // ...
default: // ...
}
```

note:
マッチングもできます

+++

```swift
let table = zip(1...,
                ["🍎", "🍇", "🍐", "🍓"])
table.forEach { print($0) }
/*
 (1, "🍎")
 (2, "🍇")
 (3, "🍐")
 (4, "🍓")
 */
```

note:
あとは、こんな感じでzipできたりします。便利そうですよね。
何ができるかわかったところで、もう少し踏み込んでみましょうか

---

どこに何の型があったの？ 🤔

note:
今紹介した使用例の中で、追加された型はどこで使われていたでしょうか

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

note:
増えたのは型が 4 つと protocolです

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

note:
proposal の motivation としてあげられていたコードに、それぞれどの型を追加して解決したのか見てみましょう。
名前が一致しているのもあり、分かりやすいですね。

+++

#### `CountablePartialRangeFrom`
#### `protocol RangeExpression`

note:
残り二つですが

+++

### `CountablePartialRangeFrom`

```swift
let table = zip(1..., // `CountablePartialRangeFrom`
                ["🍎", "🍇", "🍐", "🍓"])
table.forEach { print($0) }
/*
 (1, "🍎")
 (2, "🍇")
 (3, "🍐")
 (4, "🍓")
 */
```

note:
CountablePartialRangeFrom はここに出てきていました。
1... のところです。
一見、PartialRangeFrom と同じに見えますが、CountablePartialRangeFrom は Swift3 からあった、CountableRange の one-sided range 版です。
つまり、CountableRange と同様、Sequence の性質をもちます。

+++

#### CountablePartialRangeFrom
```swift
zip(1... as CountablePartialRangeFrom,
    ["🍎", "🍇", "🍐", "🍓"])
```


#### PartialRangeFrom
```swift
// error: Argument type 'PartialRangeFrom<Int>' does not conform to expected type 'Sequence'
zip(1... as PartialRangeFrom,
    ["🍎", "🍇", "🍐", "🍓"])
```

note:
もちろん、Int型の範囲を PartialRangeFrom で表すこともできますが Sequence の性質は持ちません。なぜなら、PartialRangeFrom は表す範囲の空間が int 刻みだとは規定していないからです。

+++

* <span class=“quiet”>Range (0..<5.0)</span>
* <span class=“quiet”>ClosedRange (“a”…”z”)</span>
* <span class="special">`CountableRange` (0..<5)</span>
* <span class="special">`CountableClosedRange` (0...5)</span>
* <span class="quiet">PartialRangeFrom (5.0...)</span>
* <span class="quiet">PartialRangeUpTo (..<5.0)</span>
* <span class="quiet">PartialRangeThrough (...5.0)</span>
* <span class="special">CountablePartialRangeFrom (5...)</span>
* <span class="quiet">protocol RangeExpression</span>

note:
CountableRange　の仲間として一つ種類が増えた、という感じです。

+++

### `protocol RangeExpression`

note:
最後に、RangeExpressionです。

+++

Range を表す全ての型が  
`RangeExpression` に準拠

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

note:
範囲を表す全ての型が `RangeExpression` に準拠するように変更されました。
この protocol のモチベーションは Range 型への変換を備えることです。

+++

<div class="special">
コレクション(*Range.Bound == Collection.Index)の  
文脈において、*Range は Range 型に変換可能  
=  
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

note:
範囲を表す型が増えても、それらを RangeExpression として抽象化し、
Range 型に変換可能、つまり、扱う際に ”Range 型" として統一して使用可能にしたことで、複雑化を回避できます。

---

### まとめ

* One-sided Ranges が追加
* Range 周りの設計が少し変更された
* 複雑化したように見えて、意外と簡単

note:
Swift4 では、One-sided Ranges が追加され、Range 周りが少し変わりました。
Rangeは少し渋い部分ではありますが、成り立ちから知っておくと、ドラマがあっておもしろいかなと思います。

---

### 参考

* [apple/swift-evolution/proposals/0172-one-sided-ranges.md](https://github.com/apple/swift-evolution/blob/master/proposals/0172-one-sided-ranges.md)
* [[stdlib] One-sided ranges and RangeExpression](https://github.com/apple/swift/pull/8710/files)
* [apple/swift/docs/StringManifesto.md String Processing For Swift 4](https://github.com/apple/swift/blob/master/docs/StringManifesto.md#unification-of-slicing-operations)
* [Swift 3のRange徹底解説](http://qiita.com/mono0926/items/88779ceff30f8fc705c5)
* [What’s New in Swift 4?](https://www.raywenderlich.com/163857/whats-new-swift-4)
