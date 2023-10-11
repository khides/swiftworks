// 8.2 値の受け渡し方法による型分類 ///////////////////////////////////
// 値型と参照型
// ・値型
// // 複数の変数や定数で一つの値型のインスタンスを共有することはできない
// // 一度代入したインスタンスは再代入を行わない限り不変
// // 構造体と列挙型は値型
struct Color  {
    var red: Int
    var green: Int
    var blue: Int
}
var a = Color(red: 255, green: 0, blue: 0)
var b = a
a.red = 0
print(a)
print(b) // aとｂの中身は異なる

// ・mutatingキーワード　
// // 型の中で自分自身を変更する処理を実行　例えばappendメソッドは内部にmutatingを内包
extension Int {
    mutating func increment() -> Void {
        self += 1
    }
}
var a = 1
a.increment()

let b = 1
// b.increment() //bに再代入ができないためコンパイルエラー　letは値の変更を防ぎたい場合に役立つ


// ・参照型
// 複数の変数や定数で一つのインスタンスを共有できる
// クラスが参照型
class IntBox {
    var value: Int
    init(value: Int){
        self.value = value
    }
}
var a = IntBox(value: 1)
var b = a

a.value = 1
print(b.value) //aとbはインスタンスを共有する

// 安全にデータを取り扱うには値型、状態管理など変更の共有が必要な場合にのみ参照型を使用する



// 8.3 構造体 //////////////////////////////////////////////////////////
struct Article {
    let id: Int
    let title: String
    let body: String

    init(id:Int, title: String, body: String){
        self.id = id
        self.title = title
        self.body = body
    }
    func printBody() -> Void {
        print(self.body)
    }
}
let article = Article(id: 1, title: "title", body: "body")
article.printBody()

// 定数のストアドプロパティは変更できない
struct SomeStruct {

    var id: Int
    init(id: Int){
        self.id = id
    }
}
var variable = SomeStruct(id: 1)
variable.id = 2 //OK
let constant = SomeStruct(id: 1)
// constant.id = 2 // コンパイルエラー

// メソッド内でストアドプロパティを変更するには、mutatingキーワードが必要
struct SomeStruct {
    var id : Int
    init(id: Int){
        self.id = id
    }
    mutating func someMethod() -> Void { //mutatingをつけないとコンパイルエラー
        self.id = 4
    }
}
var a = SomeStruct(id: 1)
a.someMethod()
print(a.id)

// ・メンバーワイズイニシャライザ
// デフォルトで用意されるイニシャライザ
struct Mail {
    var subject = "no subject"
    var body: String

}
let noSubject = Mail(body: "hello")
print(noSubject.subject)


// 8.4 クラス ////////////////////////////////////////////////////////
class SomeClass {
    let id: Int
    let name: String
    init(id: Int, name: String){
        self.id = id
        self.name = name
    }
    func printName() -> Void {
        print(self.name)
    }
}
let instance = SomeClass(id: 1, name: "name")
instance.printName()

// ・クラス継承
class User {
    let id: Int
    var message: String{
        return "hello"
    }
    init(id:Int){
        self.id = id
    }
    func printProfile() -> Void {
        print("id: \(self.id)")
        print("message: \(self.message)")
    }
}
class RegisteredUser: User {
    let name: String
    override var message: String{ // オーバーライド(型の構成要素の再定義)
        return "hello, my name is \(self.name)"
    }
    init(id: Int, name: String){
        self.name = name 
        super.init(id: id)
    }
    override func printProfile() -> Void {
        super .printProfile()
        print("name: \(self.name)")
    }
}
let user = User(id: 1)
user.printProfile()
let registeredUser = RegisteredUser(id: 2, name: "Taro")
registeredUser.printProfile()

// ・final キーワード
// 継承とオーバーライドの禁止
class SuperClass {
    func overridableMethod() -> Void {
    }
    final func finalMethod() -> Void {
    }   
}
class subClass: SuperClass {
    override func overridableMethod() -> Void {
    }
    // override func finalMethod() -> Void {        
    // }  // オーバーライド不可能
}

// ・クラスに紐づく要素
// クラスプロパティ・クラスメソッドと、スタティックプロパティ・スタティックメソッド
class A {
    class var className: String{
        return "A"
    }
    static var baseClassName: String{
        return "A"
    }
    class func someMethod() -> String {
        return "a"
    }
}
class B: A {
    override class var className: String{
        return "B"
    }
    // override static var baseClassName: String{
    //     return "A"
    // } // スタティックプロパティはオーバーライドできないのでコンパイルエラー
    override class func someMethod() -> String {
        return super.someMethod() + "->B"
    }
} // 型に紐づく要素を定義する場合、サブクラスで変更できるかどうかで使いわけ


// ・指定イニシャライザとコンビニエンスイニシャライザ
// 指定イニシャライザ：クラスの主となるイニシャライザ
// コンビニエンスイニシャライザ：指定イニシャライザを中継するイニシャライザ
// 様々な階層で定義されたプロパティが初期化されることを保証する仕組み
class Mail {
    let from: String
    let to: String
    let title: String

    // 指定イニシャライザ
    init(from: String, to: String, title: String){
        self.from = from
        self.to = to
        self.title = title
    }
    // コンビニエンスイニシャライザ
    convenience init(from: String, to: String){
        self.init(from: from, to: to, title: "hello, \(self.from)")
    }
}
// 二段階初期化
class User {

    let id: Int

    init(id:Int){
        self.id = id
    }

    func printProfile() -> Void {
        print("id: \(self.id)")
    }
}
class RegisteredUser: User {

    let name: String

    init(id:Int, name:String){ // 一段階目
        self.name = name
        super.init(id: Int) // 二段階目
        self.printProfile()
    }
}

// デフォルトイニシャライザ
class User {

    let id = 0
    let name = "Taro"
    //　暗黙的に指定イニシャライザが定義される
}


// ・クラスのメモリ管理
// クラスが不要になったタイミングでメモリを解放する
class SomeClass {
    deinit{
    }
}


// ・値の比較と参照の比較
// 参照型であるクラスの値は変わりやすい
class SomeClass: Equatable {
    static func == (lhs: SomeClass, rhs: SomeClass) -> Bool {
        return true
    }
}
let a = SomeClass()
let b = SomeClass()
let c = a

print(a == b)
print(a === b)
print(a === c)



// 8.5 列挙型 ///////////////////////////////////////////////////////////////
// ケース・イニシャライザ・コンピューテッドプロパティを保持
enum Weekday {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    init?(japajeseDay: String){
        switch japajeseDay {
        case "日": self = .sunday
        case "月": self = .monday
        case "火": self = .tuesday
        case "水": self = .wednesday
        case "木": self = .thursday
        case "金": self = .friday
        case "土": self = .saturday
        default: return nil
        }
    }
    var name: String{
        switch self {
        case .sunday: return "日"
        case .monday: return "月"
        case .tuesday: return "火"
        case .wednesday: return "水"
        case .thursday: return "木"
        case .friday: return "金"
        case .saturday: return "土"
        }
    }
}

// ・ローバリュー
// それぞれのケースの実体を定義
// ローバリューは全て同一の型である必要がある
enum Symbol: String {
    case sharp = "#"
    case doller = "$"
    case percent = "%"
}
print(Symbol.doller.rawValue)
let symbol = Symbol(rawValue: "#")
print(symbol?.rawValue)

// ・ローバリューのデフォルト値
enum Option: Int {
    case none
    case one
    case undefined = 999
}

print(Option.none.rawValue)
print(Option.undefined.rawValue)  

// ・連想値
enum Color {
    case rgb(Float, Float, Float)
    case cmyk(Float, Float, Float, Float)
}

let rgb = Color.rgb(0.0, 0.33, 0.66)
let cmyk = Color.cmyk(0.0, 0.33, 0.66, 0.99)

let color = Color.rgb(0.0, 0.0, 0.0)

switch color {
case .rgb(let r, let g, let b):
    print("r\(r), g\(g), b\(b)")
case .cmyk(let c, let m , let y , let k):
    print("c\(c), m\(m), y\(y), k\(k)")
    
}

// ・caseIterableプロトコル
// 要素列挙のプロトコル
enum Fruit: CaseIterable {
    case peash, apple, grape
}
print(Fruit.allCases) // 全要素を含むリストを返す

enum AppleColor {
    case green, red
}
enum Fruit: CaseIterable { //　連想値をもつケースを含む時、明示的にプロパティを作成する必要がある
    case peach, apple(color: AppleColor), grape
    static var allCases: [Fruit]{
        return [
            .peach,
            .apple(color: .red),
            .apple(color: .green),
            .grape,
        ]
    }
}
print(Fruit.allCases)