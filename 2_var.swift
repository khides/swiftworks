import Cocoa

var a = 1
let b = "1"

// b = "d"// コンパイルエラー

print(a)
print(type(of: a))



func someFunction() {
    let c = "c"
    print(c)
}

// print(c)//コンパイルエラー
someFunction()

// 属性・メソッド
let d = "hello world"
print(d.count)
print(d.starts(with: "hello"))


// クロージャ式
let original = [1,2,3]
let doubled = original.map({value in value*2})
print(doubled)

