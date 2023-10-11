// 3.2 Bool型 ///////////////////////////////////////////////////
let bool = true

// 3.3 Double型 ///////////////////////////////////////////////////
// 無限大　
let a = 1.0/0.0
print(a)
print(a.isInfinite)
let b = Double.infinity
print(b)
print(b.isInfinite)

// 非数
let c = 0.0/0.0
print(c)
print(c.isNaN)
let d = Double.nan
print(d)
print(d.isNaN)

// 数値ライブラリ
import Foundation
print(sin(Float.pi/4))
print(log(1.0))



// 3.4 String型////////////////////////////////////////////////////
// フォーマット
let result = 7 + 9
let output = "結果：\(result)"
print(output)

let haiku = """
五月雨を
集めて早し
最上川
"""
print(haiku)

// append
var abc = "abc"
let def = "def"
print(abc)

// 高度な操作
// 二つの文字列間の順序を比較する
import Foundation
let options = String.CompareOptions.caseInsensitive
let order = "abc".compare("ABC", options: options)
print(order == ComparisonResult.orderedSame)
// 文字列の探索
print("abc".range(of: "bc"))



// 3.5 Optional<wrapped>型/////////////////////////////////
// オプショナル型とは、値があるか、空(nil)かのいずれかを表す型
let none = Optional<Int>.none //nil
print(".none: \(String(describing: none))")
//　以下は同義
let some = Optional<Int>(1)
let some2 = Optional(1) //型推論
print("some:\(some)")
// その他の表現方法
var opt :Int?
opt = nil
opt = Optional(1)
opt = 1

// アンラップ
// オプショナル型から値を取り出すには以下のアンラップ処理が必要
// 1. オプショナルバインディング
let optionalA :String? =  Optional("a")
if let a = optionalA { // 値が存在するときのみ実行
    print(type(of: a))
}

// 2.??演算子
// 値を持たないとき、デフォルト値を返す
let optionalInt = Optional(1)
let int = optionalInt ?? 3  //デフォルト値３

//　3.強制アンラップ
// もしも値が存在しなかったとき、実行時までエラーが出ないため非推奨
let optionalA = Optional(1)
let optionalB = Optional(2)
print(optionalA! + optionalB!)

// 4.オプショナルチェイン
let optionalDouble :Double? =  Optional.none
    // もしoptionalDouble がnilだった場合、この変数に関する以降の処理は行われず、nilが返される
let optionalIsInfinite = optionalDouble?.isInfinite 
print(String(describing: optionalIsInfinite))

// 5.map と flatMap
// アンラップを伴わずに値の変換を行う
let optionalA : Int? = Optional.none
let optionalB = optionalA.map({val in val * 2}) // Aの値が空の場合、nilを返す
print(type(of: optionalB))
print(optionalB)

let optionalC : Int? = Optional(17)
let optionalD = optionalC.map({val in String(val)}) //キャストも可能
print(type(of: optionalD))
print(optionalD)

let optionalE :String? = Optional("17")
let optionalF = optionalE.flatMap({val in Int(val)})
// let optionalF = optionalE.map({val in Int(val)}) //これだと、optionalが二重になるので、flatMapを使うべき
print(type(of: optionalF))
print(optionalF)

//　6.暗黙的にアンラップされたOptional<wrapped>型
// !で定義されたオプショナル型は値のアクセス時に自動的に強制アンラップを行う
// 値が空の時、エラーが実行時まで見えないので非推奨
var optionalA: Int? = 1
var optionalB: Int! = 1
// print(optionalA + 1)
print(optionalB + 1)



// 3.6 Any型 /////////////////////////////////////////////////////////////////////////
let str: Any = "1"
let int: Any = 1



// 3.7 Tupple型 ///////////////////////////////////////////////////////////////////////
let tupple = (int: 1, string: "a")
print(tupple.int)
print(tupple.0)

let (int, string) = (1, "a")
print(int)
// void
// 空のタプル
()



// 3.8 型のキャスト //////////////////////////////////////////////////////////////////////
// アップキャスト　as
// 階層下位の型を上位の抽象的な型として扱う
let any = "abc" as Any
// let any: Any = "abc"


//　ダウンキャスト as?
// 階層上位の型を下位の具体的な型として扱う
let any = 1 as Any
let int = any as? Int
let string = any as? String //nil
print(int, string)
// 強制ダウンキャスト as!　非推奨
let any = 1 as Any
let int = any as! Int
let string = any as! String //実行時エラー
print(int, string)



// 3.9　基本的な型に関連したプロトコル //////////////////////////////////////////////////////
// Equatableプロトコル
let boolleft = true
let boolright = true
print(boolleft == boolright)

// Comparableプロトコル
let intleft = 1
let intright = 2
print(intleft < intright)