//4.2 Array<Element>型 ////////////////////////////////////////
// 基本的に多言語の配列やリストと変わらん
let array: [Int] = []
var integers = [1,2,3]
integers.append(4)
print(integers)
integers.insert(0, at: 0)
print(integers)
var integers2 = [5,6,7]
let result = integers + integers2
print(result)
integers2.remove(at: 0)
print(integers2)
integers2.removeLast()
print(integers2)
integers2.removeAll()
print(integers2)


//4.3 Dictionary<Key, Value>型 ///////////////////////////////////
// 基本的に多言語の辞書型と変わらん
let dictionary = ["key": 1]
print(dictionary["key"])


//4.4 Range型 /////////////////////////////////////////////////////
let range = 1..<4
for val in range{
    print(val)
}
print(range.lowerBound) //下底
print(range.upperBound) //上底
print(range.contains(2))


// 4.5 String型
// String型はCharacter型のCollectionとみなせる
let string = "a"
let charactor : Character = "a"
var str = "abc"
print(str.startIndex)
print(str.endIndex)
print(str[str.startIndex])
// print(str[str.endIndex])// 実行時エラー
print(str.index(str.startIndex, offsetBy: 1))
print(str.count)
for chr in str{
    print(chr)
}

// 4.6 Collectionに関連したプロトコル
//  Sequence プロトコル
// for in　を用いて順次アクセス可能
// 加えて以下のメソッドを使用可能
let array = [1,2,3,4,5,6,7]
var gap = 0
array.forEach({elm in gap -= elm})
print(gap)

let filtered = array.filter({elm in elm % 2 == 0})
print(filtered)

let doubled = array.map({elm in elm * 2})
print(doubled)

let array2 = array.flatMap({elm in [elm, elm + 1]})
print(array2)

let strings = ["abc", "123", "def", "345"]
let integers = strings.compactMap({elm in Int(elm)})// 失敗した処理を無視する
print(integers)

let sum = array.reduce(0, {result, elm in result + elm})
print(sum)

let concat = array.reduce("", {result, elm in result + String(elm)})
print(concat)


// Collection プロトコル
// Sequenceプロトコルの継承プロトコル
// 以下のメソッドを追加で使用可能
let array = [1,2,3,4,5,6,7]
print(array[3])
print(array.isEmpty)
print(array.count)
print(array.first)
print(array.last)

