// 6.2 関数 //////////////////////////////////////////////////////////////
// ・引数 ///////////////////////////////////////////////
// // func someFunc(外部引数 内部引数: 型 = デフォルト引数)
// // someFunc(実引数)
func sum (_ int1: Int = 0, _ int2: Int = 0) -> Int {
    return int1 + int2
}
print(sum(1,2))


// ・inout 引数 //////////////////////////////////////////
// // 他の言語でいうところの参照渡し
// // 関数外に引数の変更を共有する
func greet(user: inout String) -> Void {
    if user.isEmpty {
        user = "Anonymous"
    }
    print(user)
}
var user = "taro"
greet(user: &user)
print(user)


//　・可変長引数 ///////////////////////////////////////////
// // 任意の個数の引数を受け取ることができる
func pprint(strings: String...) -> Void {
    if strings.count == 0 {
        return
    }
    print("first: \(strings[0])")

    for string in strings {
        print("element: \(string)")
    }
}
pprint(strings: "abc", "def", "ghi")



// 6.3 クロージャ /////////////////////////////////////////////////////////////////
let double = {(x:Int)->Int in
    return x*2
}
print(double(2))

// // 引数と戻り値のかたを省略した場合
var closure: (String) -> Int
closure = { string in
    return string.count*2}
print(closure("abc"))

// ・簡易引数 //////////////////////////////////////////////
let isEqual: (Int, Int) -> Bool = {
    return $0 == $1 // $nで第n引数を表す
}
print(isEqual(1,2))


// ・キャプチャ /////////////////////////////////////////////
// // クロージャが参照する変数や定数はクロージャ自身が定義されたスコープ外でも使用可能
let counter: ()->Int
do{
    var count = 0 //countはdoスコープ内で宣言されているが、スコープ外でクロージャを使用可能
    counter = {
        count += 1
        return count
    }
}
print(counter())
print(counter()) // ただし、クロージャ内で保持する形なので、実行する度値が替わる


// ・属性 //////////////////////////////////////////////////////
// // ・escaping属性
// // 非同期的に実行される
var queue = [()->Void]() // クロージャのリスト
// // 引数にクロージャを取った場合、その関数内でクロージャを実行しないとき、escaping属性が必要
func enqueue(operation: @escaping ()->Void) -> Void { 
    queue.append(operation)
}
enqueue {
    print("executed") // print()関数をawaitするイメージ
}
queue.forEach{ // 実行
    $0()
}

// // ・autoclosure属性
/* 関数やクロージャが引数の場合、どちらかをautoclosure属性にすることで、
どちらかの実行のみでいい時はどちらかしか実行しない*/
// // 特にコストの高い処理を行う時、必要がないときは処理を実行しない方がいい
func or (_ lhs:Bool, _ rhs: @autoclosure()->Bool) -> Bool {
    if lhs{
        // print("true")
        return true
    }else {
        let rhs = rhs()
        // print(rhs)
        return rhs
    }
}
func lhs() -> Bool {
    print("lhs 実行")
    return true    
}
func rhs() -> Bool {
    print("rhs 実行")
    return false
}
print(or(lhs(), rhs())) 


// // ・trailing closure (syntax sugar)
// // クロージャが引数の場合、クロージャのみを（）外に出す記法をしてよい
func execute (parameter: Int, handler: (String) -> Void) -> Void {
    handler("parameter is \(parameter)")
}
execute(parameter: 1, handler: {string in
    print(string)
})
execute(parameter: 1){string in
    print(string)
}

