// // 引数と戻り値のかたを省略した場合
var closure: (String) -> Int
closure = { string in
    return string.count*2}
print(closure("abc"))
