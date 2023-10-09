// ジェネリクスが便利な場面
func isEqual <T: Equatable>(_ x: T, _ y: T) -> Bool {
    return x == y
}
print(isEqual(1, 1))

// 特殊化法
struct Container<Content> { // 内部で使用するプロパティの型を事前に決めないでおく
    let content: Content
}
let stringContainer = Container<String>(content: "abc")

let intContainer = Container(content: 1)


// 型の安全性
// 引数と戻り値の型が同じことを保証する
func identity<T>(_ argument: T) -> T {
    return argument
}
let int = identity<Int>(1)
let string = identity("abc")


// ジェネリクスを使用した関数
func identityWithGenericValue<T>(_ argument: T) -> T {
    return argument
}
let genericInt = identityWithGenericValue(1)
print(genericInt)
let genericString = identityWithGenericValue("abc")
// Any型を使用すると型の安全性を失う
func identityWithAnyValue(_ argument: Any) -> Any {
    return argument
}
let anyInt = identityWithAnyValue(1)
if let int = anyInt as? Int {
    print(int)
}


// ジェネリック関数
// 引数による型推論
func someFunction<T>(_ argument: T) -> T {
    return argument
}
let int = someFunction(1)
let string = someFunction("abc")
// 戻り値による型推論
func someFunction<T>(_ any: Any) -> T? {
    return any as? T
}
let a:String? = someFunction("abc")
print(a)
// let b = someFunction("abc")  //Tが決定できずコンパイルエラー


// 型制約
func isEqual<T :Equatable>(_ x: T, _ y: T) -> Bool {
    return x == y
}
isEqual("abc", "def")


// 型の連想型の制約
func sorted<T: Collection>(_ argument: T) -> [T.Element] where T.Element: Comparable {
    return argument.sorted()
}
print(sorted([3,2,1]))

func concat<T: Collection, U: Collection>(_ argument1: T, _ argument2: U) 
-> [T.Element] where T.Element == U.Element{
    return Array(argument1) + Array(argument2)   
}

let array = [1,2,3]
let set = Set([1,2,3])
print(concat(array, set))


// ジェネリック型
struct GenericStruct<T> {
    var property: T
}
class GenericClass<T> {
    func someFunction(x: T) -> Void {
    }
}
enum GenericEnum<T> {
    case SomeCase(T)
}

// 型制約
struct Pair<Element> {
    let first: Element
    let second: Element
}
extension Pair where Element == String {
    func hasElement(containing character: Character) -> Bool {
        return first.contains(character) || second.contains(character)
    }
}
let stringPair = Pair(first: "abc", second: "def")
print(stringPair.hasElement(containing: "e"))