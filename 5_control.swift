// 5.2　条件分岐 //////////////////////////////////////////////////////////////////
// ・if else 文 /////////////////////////////////////////////
// // 多言語と変わりません

// ・if let 文 //////////////////////////////////////////////
// // 値の有無によって条件分岐する
// // アンラップを安全に行える（オプショナルバインディング）
let key = "one"
let dict = ["one":1,"two":2,"three":3,"four":4]
print(type(of: dict[key]))
let value: Int // if let で宣言された定数(val)はスコープ外では使用できないため、外で使いたい時は外に定数を用意しておく
if let val = dict[key] {
    value = val //値が存在したら実行
    print(val + 10)
} else {
    print("not exist") // 値が存在しなかったら実行
    value = -1
}
print(value)

// // ダウンキャストを安全に行える
let a: Any = 1
if let int = a as? Int {
    print(int)
}


// ・guard 文 ///////////////////////////////////////////////////////
// // 条件不成立時に早期退出する分岐
var val = -1
func someFunction(_ val: Int) -> Void {
    guard val >= 0 else {
        print("0未満です")
        return // guard文は記述されているスコープ外に出る必要がある(returnやbreakが必須)
    }
    print("0以上です")
}
someFunction(val)


// ・guard let 文 /////////////////////////////////////////////////////
let key = "one"
let dict = ["one":1,"two":2,"three":3,"four":4]
print(type(of: dict[key]))
func someFunction(_ key : String) -> Void {
    guard let val = dict[key] else {
        print("not exist")    
    return
    }
    print(val) //guard文で宣言した定数をスコープ外で使うことができる
}
someFunction(key)



//　・switch文 ////////////////////////////////////////////////////////
// // 集合に属する
let a = 1
switch a {
case Int.min..<0:
    print("負の数です")
case 1..<Int.max:
    print("正の数です")
default:
    print("0です") 
}

// // 列挙型の使用
enum SomeEnum {
    case foo
    case bar
    case baz
}
let member = SomeEnum.foo
switch member {
case .foo:
    print(".foo")
case .bar:
    print(".bar")
case .baz:
    print(".baz") //caseの網羅性を確保しないと、コンパイルエラーになる
}
// // caseの網羅性の観点からdefaultキーワードはなるべく使用すべきでない


// // ・whereキーワード /////////////////////////////
// // ケースに条件を追加する
let optionalA : Int? = 1
switch optionalA {
case .some(let a) where a > 10:
    print("10よりおきい\(a)が存在")    
default:
    print("値が存在しないまたは１０以下")
}
// // case 制御式に当てられた値の型の分類パターン　where 条件式
// // print(Optional.some(1))


// // ・switchラベル //////////////////////////
// // break文の制御対象の指定
let value = 0 as Any

outerswitch: switch value {
case let int as Int:
    let description: String
    innerswitch: switch int {
    case 1,3,5,7,9:
        description = "odd"
    case 2,4,6,8,10:
        description = "even"
    default:
        print("out of range")
        break outerswitch //外側のswitch文を退出        
    }
    print("the number is \(description)")
default:
    print("out of type")   
}

// // ・fallthrough 文 /////////////////////
// // 次のケースへの移動
let a = 1

switch a {
case 1:
    print("case 1")
    fallthrough //　次のケースへ移動
case 2:
    print("case 2")
default:
    print("default")   
}


// 5.3 繰り返し /////////////////////////////////////////////////////////////////////////
// ・for-in 文 //////////////////////////////////////////////////////////

// ・while 文　/////////////////////////////////////////////////////////

// ・repeat while 文 /////////////////////////////////////////////////////
// do-whileみたいな
var a = 1
repeat {
    print(a)
    a += 1
} while a<1


// ・loop ラベル
// // breakやcontinueの制御対象の指定
label: for val in [1,2,3] {
    for nestedval in [1,2,3] {
        print("value:\(val), nestedbvalue: \(nestedval)")
        break label //内側から外側のループを抜けることができる
        // continue label //コンティニューも同様
    }
}


// 5.4 遅延実行 /////////////////////////////////////////////////////////////////////////
// ・defer文 ////////////////////////////////////////////////////
// // 処理の実行がスコープの退出時に行われる
var count = 0
func someFunction() -> Int {
    defer { // defer内の処理は関数を抜けた後実行される
        count += 1
    }
    print(count)
    return count
}
someFunction()
print(count)



// 5.5 パターンマッチ/////////////////////////////////////////////////////////////////
// 値が特定のパターンに合致するかを判定する
// ・式パターン  ////////////////////////////////////
// //制御式で指定した値を包含するかを評価
let integer = 9
switch integer {
case 6:
    print("match 6")
case 5...10:
    print("match 5~10")
default:
    print("default")    
}

// ・バリューバインディングパターン //////////////////////
// // 代入ができるかを評価
let value = 3
switch value {
case let matchvalue:
    print(matchvalue)
}


// ・オプショナルパターン ////////////////////////////
// // 代入した後、値の有無の評価
let optionalA = Optional(4)
switch optionalA {
case let a?:
    print(a)
default:
    print("nil")    
}


// ・列挙型ケースパターン ////////////////////////////
// //　列挙型のケースとの一致を評価
enum Hemisphere {
    case northern
    case southern
}
let hemisphere = Hemisphere.northern
switch hemisphere {
case .northern:
    print("match .northern")
case .southern:
    print("match .southern")
}
// // 連想値あり　列挙型のケースで分けるのに加え、連想値を代入する
enum Color {
    case rgb(Int, Int, Int)
    case cmyk(Int, Int, Int, Int)
}
let color = Color.rgb(100, 200, 255)
switch color {
case .rgb(let r, let g, let b):
    print("rgb: \((r,g,b))")
case .cmyk(let c , let m , let y, let k):
    print("cmyk: \((c,m,y,k))")    
}


// ・is演算子により型キャスティングパターン //////////////////////
// // キャストができるかどうか
let any: Any = 1
switch any {
case is String:
    print("match String")
case is Int:
    print("match Int")
default:
    print("default")
}


// as演算子による型キャスティングパターン　/////////////////////////
// // キャストができるかどうかに加え、キャストした値を受ける
let any: Any = 1
switch any {
case let string as String:
    print("match String \(string)")
case let int as Int:
    print("match Int \(int)")
default:
    print("default")
    
}


// // switch文以外でパターンマッチングが使える場所
// // ・if 文
let val = 9
if case 1...10 = val{
    print("match 1~10")
}

// // ・guard文
func someFunction() -> Void {
    let val = 9
    guard case 1...10 = val else {
        return
    }
    print(val)
    print("match 1~10")
}

// // ・for 文
let array = [1,2,3,4]
for case 2...3 in array{ // 各要素がマッチした時実行される
    print("match 2~3")
}

// // ・while文
var nextvalue = Optional(1)
while case let value? = nextvalue{ //オプショナルパターンを使ってアンラップ
    print("value: \(value)")
    print(type(of: value))
    if value > 3{
        nextvalue = nil
    }else{
        nextvalue = value+1
    }
}
