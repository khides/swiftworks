// プロトコルの使用法
func printIfEqual <T: Equatable> (_ arg1: T, _ arg2: T) -> Void {
    if arg1 == arg2 {
        print("Both are \(arg1)")
    }
}
printIfEqual(123, 123)
printIfEqual("str", "str")

// 作成方法と準拠方法
// 構造体の準拠
protocol SomeProtocol { // someMethodを持つようなプロトコルを定義
    func someMethod() -> Void
}
struct SomeStruct1: SomeProtocol {
    func someMethod() -> Void {}
}
// struct SomeStruct2: SomeProtocol {
// } // someMethodが定義されていないためコンパイルエラー

// クラスの準拠
// 継承先のクラス、プロトコルの順にかく
protocol SomeProtocol {
}
class SomeSuperClass {
}
class SomeClass: SomeSuperClass, SomeProtocol {
}

// エクステンションでプロトコルの準拠させる
// プロトコルごとに準拠させるのが良い
protocol SomeProtocol1 {
    func someMethod1() -> Void
}
protocol SomeProtocol2 {
    func someMethod2() -> Void 
}
struct SomeStruct {
    let someProperty: Int
}
extension SomeStruct: SomeProtocol1 {

    func someMethod1() -> Void {
    }
}
extension SomeStruct: SomeProtocol2 {

    func someMethod2() -> Void {
    }
}

// プロトコルの利用方法
protocol SomeProtocol {
    var variable: Int{
        get 
    }
}
func someMethod(x: SomeProtocol) -> Void {
    x.variable
}

// プロトコルコンポジション
protocol SomeProtocol1 {
    var variable1: Int{
        get
    }
}
protocol SomeProtocol2 {
    var variable2: Int{
        get
    }
}
struct SomeStruct: SomeProtocol1, SomeProtocol2 {
    var variable1: Int
    var variable2: Int    
}
func someFunction(x: SomeProtocol1 & SomeProtocol2) -> Int { //複数のプロトコルに準拠する引数を取る
    return x.variable1 + x.variable2
}
let a = SomeStruct(variable1: 1, variable2: 2)
print(someFunction(x: a))

// mutatingキーワード
protocol SomeProtocol {
    mutating func someMutatingMethod() ->  Void
    func someMethod() -> Void 
}
// 構造体
struct SomeStruct {
    var number: Int
    mutating func someMutatingMethod() -> Void {
        self.number = 1
    }
    // func someMethod() -> Void {
    //     self.number = 1
    // } // 自身の値を変更する処理はかけないのでコンパイルエラー
}
// クラス
class SomeClass {
    var number = 0

    // クラスは参照型なので、自身の値を変更する際、mutatingキーワードは必要ない
    func someMutatingMethod() -> Void {
        self.number = 1
    }
    func someMethod() -> Void {
        self.number = 1
    }
}

// 連想型
// プロトコル定義時に、プロパティの型を一意に決定せず、仮にAssociatedTypeとしておくことができる
protocol SomeProtocol {
    associatedtype AssociatedType 
    var value: AssociatedType{
        get
    }
    func someMethod(value: AssociatedType) -> AssociatedType
}

struct SomeStruct: SomeProtocol {
    typealias AssociatedType = Int
    var value: AssociatedType
    func someMethod(value: AssociatedType) -> AssociatedType {
        return 1
    }
}

struct SomeStruct2: SomeProtocol {
    var value: Int
    func someMethod(value: Int) -> Int {
        return 1
    }
}

struct SomeStruct3: SomeProtocol {
    struct AssociatedType {
    }
    var value: AssociatedType
    func someMethod(value: AssociatedType) -> AssociatedType {
        return AssociatedType()
    }
}

// 連想型の使用例
protocol RandomValueGenerator {
    associatedtype Value  //仮にValue型としておく
    func randomValue() -> Value
}
struct IntegerRandomValueGenerator: RandomValueGenerator {
    func randomValue () -> Int {
        return Int.random(in: Int.min...Int.max)
    }
}
struct StringRandomValueGenerator: RandomValueGenerator {
    func randomValue() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        let offset = Int.random(in: 0..<letters.count)
        let index = letters.index(letters.startIndex, offsetBy: offset)
        return String(letters[index])
    }
}


// 連想型に型制約を追加する
class SomeClass {
}
protocol SomeProtocol {
    associatedtype AssociatedType: SomeClass
}
class SomeSubClass: SomeClass {
}
struct ConformedStruct: SomeProtocol { // SomeSubClassはSomeClassのサブクラスなので制約を満たす
    typealias AssociatedType = SomeSubClass
}
// struct NonConformedStruct: SomeProtocol {
//     typealias AssociatedType = Int
// } //IntはSomeClassのサブクラスではないのでコンパイルエラー

// より詳細な制約
protocol Container {
    associatedtype Content
}
protocol SomeData {
    associatedtype ValueContainer: Container where ValueContainer.Content: Equatable
}// SomeDataプロトコルの連想型ValueContainerが準拠する型の、連想型ContentがEquatableプロトコルに準拠している
// 準拠でなく一致の制約
protocol Container {
    associatedtype Content
}
protocol SomeData {
    associatedtype ValueContainer: Container where ValueContainer.Content == Int
}
// 複数の制約
protocol Container {
    associatedtype Content
}
protocol SomeData {
    associatedtype Value
    associatedtype ValueContainer: Container where 
    ValueContainer.Content: Equatable, ValueContainer.Content == Value
}
// デフォルト型の指定
protocol SomeProtocol {
    associatedtype AssociatedType = Int // デフォルトの型
}
struct SomeStruct: SomeProtocol {
    // SomeStruct.AssociatedTypeはIntになる
}

// プロトコルの継承
protocol ProtocolA {
    var id: Int{
        get
    }
}
protocol ProtocolB {
    var title: String{
        get
    }
}
protocol ProtocolC: ProtocolA, ProtocolB {
}

// クラス専用プロトコル
protocol SomeClassOnlyProtocol: class {    
}



// プロトコルエクステンション
protocol Item { // Itemプロトコルに準拠する型はnameプロパティとcategoryプロパティを持つ
    var name: String{
        get
    }
    var category: String{
        get
    }
}
extension Item { //さらにdescriptionコンピューテッドプロパティを持つ
    var description: String{
        return "商品名：\(self.name), カテゴリ：\(self.category)"
    }
}
struct Book: Item {
    let name: String
    var category: String{
        return "書籍"
    }
}
let book = Book(name: "swift実践入門")
print(book.description)


// デフォルト実装
protocol Item {
    var name: String{
        get
    }
    var caution: String?{
        get
    }
}
extension Item {
    var caution: String?{ 
        //デフォルト実装のため、必ずしもcautionプロパティを実装するは必要なく、実装されなかった場合デフォルト値(nil)が返される
        return nil
    }
    var description: String {
        var description = "商品名:\(self.name)"
        if let caution = self.caution{
            description += "、注意事項: \(caution)"
        }
        return description
    }
}
struct Book: Item {
    let name: String
}
struct Fish: Item {
    let name : String
    var caution: String?{
        return "クール便での配送となります"
    }
}
let book = Book(name: "Swift実践入門")
print(book.description)
print(book.caution)
let fish = Fish(name: "秋刀魚")
print(fish.description)


// 型制約の追加
extension Collection where Element == Int {
    var sum: Int{
        return reduce(0, {return $0 + $1})
    }
}
let integers = [1,2,3]
print(integers.sum)
