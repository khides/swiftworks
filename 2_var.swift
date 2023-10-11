import Cocoa

var a = 1 //変数(何度でも再代入可能)
let b = "1" //定数(初回以降再代入不可)
// b = "d"// コンパイルエラー
print(a)
print(type(of: a))


// 関数//////////////////////////////////////
func someFunction() {
    let a = "a"
    print(a)
}
// print(a)　//コンパイルエラー
someFunction()

// 属性・メソッド///////////////////////////////
let a = "hello world"
print(a.count)
print(a.starts(with: "hello"))


// クロージャ式/////////////////////////////////
let original = [1,2,3]
let doubled = original.map({value in value*2})
print(doubled)

