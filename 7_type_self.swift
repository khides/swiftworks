// 構造体
struct SomeStruct {
    let val: Int
    init(value: Int){
        self.val = value
    }
}
var stct = SomeStruct(value: 1)
print(stct.val)

// 7.3 プロパティ
// ・インスタンスプロパティ
// // インスタンスプロパティはインスタンス(greeting1, greeting2)ごとに変更可能
struct Greeting {
    var to = "taro"
    var body = "Hello!"
}
let greeting1 = Greeting()
var greeting2 = Greeting()
greeting2.to = "jiro"
print(greeting1.to) // toを上で変更したが、taroのまま
print(greeting2.to)


// ・スタティックプロパティ
// // 型自身に紐づくプロパティ
// // インスタンス間で共通する値の保持
struct Greeting {
    static var sign:String = "sent from iPhone" //必ず初期化が必要    
    var to:String = "taro"
    var body:String = "Hello!"
}
let greeting1 = Greeting()
var greeting2 = Greeting()
print(Greeting.sign)
Greeting.sign = "sent from Android"
print(Greeting.sign)

// ・ストアドプロパティ
// 値を保持するプロパティ
// // ・プロパティオブザーバ
// // ストアドプロパティの変更を監視して、変更がある時、その前と後に処理を入れる
struct Greeting {
    var to = "taro" {
        willSet {
            print("willSet \(self.to)-> newValue:\(newValue)")
        }
        didSet {
            print("didSet: \(self.to)")
        }
    }
}
var greeting = Greeting()
greeting.to = "jiro"


// // ・レイジーストアドプロパティ
// // アクセス時まで初期化を遅延させるプロパティ
struct SomeStruct {
    var value = {
        print("value 生成") //通常のプロパティはインスタンス初期化時に生成
        return 1
    }()

    lazy var lazyvalue = {
        print("lazyvalue 生成") // lazyプロパティはアクセス時に生成（コストの高いプロパティを後回しにする）
        return 2
    }()
}
var some = SomeStruct()
print("structインスタンス化")
print("valueの値は\(some.value)")
print("lazyの値は\(some.lazyvalue)")



// // ・コンピューテッドプロパティ
// // 値を保持せずに算出するプロパティ
// プロパティの値を自動的に更新する（pyなら、更新する用のメソッドを実行する必要がある）
struct Temperature {
    var celsius: Double = 0.0

    var fahrenheit: Double {
        get { // 値の返却
            return (9.0/5.0)*self.celsius + 32.0
        }
        set { // 値の更新
            self.celsius = (5.0/9.0)*(newValue - 32.0)
        }
    }
}
var temp = Temperature()
print(temp.celsius)
print(temp.fahrenheit)
temp.fahrenheit = 40
print(temp.celsius) 

// 7.4 イニシャライザ ////////////////////////////////////////////////////
// ・失敗可能イニシャライザ /////////////////////////////
// // 初期化の失敗を考慮したイニシャライザ
struct Item {
    let id :Int
    let title:String

    init?(dictionary: [String: Any]){
        guard let id = dictionary["id"] as? String else { // dictは"id"を持たないかもしれない
            return nil
        } // 初期化できなケースを考慮していない場合コンパイルエラー
        self.id = id
        self.title = title
    }    
}

let dictionaries : [[String:Any]] = [
    ["id":1, "title":"abc"], //OK
    ["title": "def"] //失敗
]
for dict in dictionaries{
    if let item = Item(dictionary: dict){
        print(item)
    }else {
        print("error")
    }
}


// ・失敗可能イニシャライザとデフォルト値
struct Greeting { //失敗可能イニシャライザ
    let to: String
    var body: String{
        return "hello, \(self.to)"
    }

    init?(dictionary: [String: String]){
        guard let to = dictionary["to"] else {
            return nil
        }
        self.to = to
    }
}
struct Greeting {
    let to: String
    var body: String{
        return "hello \(self.o)"
    }
    init(dictionary: [String: String]){
        self.to = dictionary["to"] ?? "taro" //デフォルト値
    }
}


// 7.5 メソッド /////////////////////////////////////////////////////////////
// ・インスタンスメソッド
// // インスタンスに紐づくメソッド
struct SomeStruct {
    var value = 0
    func printValue() -> Void {
        print("value: \(self.value)")
    }
}
var someStruct1 = SomeStruct()
someStruct1.value = 1
someStruct1.printValue()

//　・スタティックメソッド
// // 型自身に紐づくメソッド
struct Greeting {
    static var sign = "sent from iPhone"
     static func setSign(withDeviceName deviceName: String) -> Void {
        self.sign = "sent from \(deviceName)"
     }
     var to = "taro"
     var body: String{
        return "hello ,\(to)! \n \(Greeting.sign)"
     }
}
let greeting = Greeting()
print(greeting.body)
Greeting.setSign(withDeviceName: "Android")
print(greeting.body)


// ・オーバーロード
// // 型の異なる同名のメソッドの定義
// // 引数によるオーバーロード 
struct Printer {
    func put (_ value: String) -> Void {
        print("string: \(value)")
    }
    func put (_ value: Int) -> Void {
        print("int \(value)")
    }
}

// // 戻り値によるオーバーロード
struct ValueCounter {
    let stirngValue = "abc"
    let intValue = 123

    func getVallue() -> String {
        return self.stirngValue
    }
    func getVallue() -> Int {
        return self.intValue
    }
}

// 7.6 サブスクリプト ////////////////////////////////////////////////////////
// コレクションの要素へのアクセス
// インデックスで操作できる型を作りたい
// オーバーロード等のメソッドと同様に可能
struct Progression {
    var numbers: [Int]

    subscript(index: Int)->Int{
        get{
            return numbers[index]
        }
        set {
            numbers[index] = newValue
        }
    }
}
var progression = Progression(numbers: [1,2,3])

let elm = progression[1]
print(elm)
progression[1] = 4
let elm2 = progression[1]
print(elm2)


// 7.7 エクステンション //////////////////////////////////////////////////
// 存在する型の拡張
// ・メソッドの追加
extension String {
    func printSelf() -> Void {
        print(self)
    }
}
let string = "abc"
string.printSelf()
// ・コンピューテッドプロパティの追加
extension String {
    var encodedString: String{
        return "【\(self)】"
    }
}
print("警告".encodedString)
// ・イニシャライザの追加
import UIKit
enum WebAPIError: Error {
    case connectionError(Error)
    case fatalError

    var title: String{
        switch self {
        case .connectionError:
            return "通信エラー"
        case .fatalError:
            return "致命的なエラー"
        }
    }
    var message: String{
        switch self {
        case .connectionError(let underlyingError):
            return underlyingError.localizedDescription + "再試行してください"
        case .fatalError:
            "サポート窓口に連絡してください"
        }
    }
}

extension UIAlertController {
    convenience init(WebAPIError: WebAPIError){
        // UIAlertController の指定イニシャライザ
        self.init(title: WebAPIError.title,
        message: WebAPIError.message,
        preferredStyle: .alert)
    }

}

let error = WebAPIError.fatalError
let alertController = UIAlertController(WebAPIError: error)


// 7.8 型のネスト /////////////////////////////////////////////////////////// 
// 型の中に型を定義できる
struct NewsFeedItem {
    enum Kind {
        case a 
        case b 
        case c 
    }
    let id: Int
    let title: String
    let kind :Kind

    init(id: Int, title: String, kind: Kind){
        self.id = id
        self.title = title
        self.kind = kind
    }
}

let kind = NewsFeedItem.Kind.a
let item = NewsFeedItem(id: 1, title: "Table", kind: kind)
switch item.kind {
case .a : print("kind is .a")
case .b : print("kind is .b")
case .c : print("kind is .c")    
}


protocol strs {
    var a:String{get set}
    mutating func change(_ str: String) -> Void
}
extension strs {
    var a:String{return "a"}
}
struct abc : strs{
    var a = "a"
        mutating func change(_ str:String) -> Void {
        self.a = str
    }
}
var a = abc()
a.change("b")
print(a.a)