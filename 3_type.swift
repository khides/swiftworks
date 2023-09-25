// 浮動小数点型
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



// 文字列型
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
import Foundation
let options = String.CompareOptions.caseInsensitive
let order = "abc".compare("ABC", options: options)
print(order == ComparisonResult.orderedSame)
print("abc".range(of: "bc"))



// optional<wrapped>型
let none = Optional<Int>.none
print(".none: \(String(describing: none))")
//　以下は同義
let some = Optional<Int>(1)
let some2 = Optional(1)
print("some:\(some)")
// その他の表現方法
var opt :Int?
opt = nil
opt = Optional(1)
opt = 1

// アンラップ
// オプショナルバインディング
let optionalA :String? =  Optional("a")
if let a = optionalA { // 値が存在するときのみ実行
    print(type(of: a))
}
//　強制アンラップ 非推奨
let optA = Optional(1)
let optB = Optional(2)
print(optA! + optB!)

// オプショナルチェイン
let optionalDouble :Double? =  Optional.none
    // もしoptionalDouble がnilだった場合、この変数に関する以降の処理は行われず、nilが返される
let optionalIsInfinite = optionalDouble?.isInfinite 
print(String(describing: optionalIsInfinite))

// map と flatMap
let optionala : Int? = Optional.none
let optionalb = optionala.map({val in val * 2})
print(type(of: optionalb))
print(optionalb)

let optionalc : Int? = Optional(17)
let optionald = optionalc.map({val in String(val)})
print(type(of: optionald))
print(optionald)

let optionale :String? = Optional("17")
let optionalf = optionale.flatMap({val in Int(val)})
// let optionalf = optionale.map({val in Int(val)})
print(type(of: optionalf))
print(optionalf)

//　暗黙的にアンラップされたOptional<wrapped>型　非推奨
var a_opt: Int? = 1
var b_opt: Int! = 1
// print(a_opt + 1)
print(b_opt + 1)




// タプル型
let tupple = (int: 1, string: "a")
print(tupple.int)
print(tupple.0)

let (int, string) = (1, "a")
print(int)



// アップキャスト
let any = "abc" as Any
// let any: Any = "abc"


//　ダウンキャスト
let any = 1 as Any
let int = any as? Int
let string = any as? String //nil
print(int, string)
// 強制ダウンキャスト
let any = 1 as Any
let int = any as! Int
let string = any as! String //実行時エラー
print(int, string)


