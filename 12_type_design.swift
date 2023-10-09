// クラスに対する構造体の優位性
// クラスがもたらすバグ
class Temperature {
    var celsius: Double = 0
}
class Country {
    var temperature: Temperature
    init(temperature: Temperature){
        self.temperature = temperature
    }
}
let temperature = Temperature()
temperature.celsius = 25
let Japan = Country(temperature: temperature)
temperature.celsius = 40
let Egypt = Country(temperature: temperature)
print(Japan.temperature.celsius)
print(Egypt.temperature.celsius) //日本の気温が４０度になってしまっている

// 非同期処理ではなおさら訳わからんくなる
import Dispatch

class Temperature {
    var celsius: Double = 0
}
let temperature = Temperature()
temperature.celsius = 25
// 別スレッドでtemperatureの値を編集
let dispatchQueue = DispatchQueue.global(qos: .default)
dispatchQueue.async {
temperature.celsius += 1
}
temperature.celsius += 1
print(temperature.celsius) //非同期処理のタイミングによって結果が異なる


// 構造体がもたらす安全性
struct Temperature {
    var celsius: Double = 0
}
struct Country {
    var temperature: Temperature
}
var temperature = Temperature()
temperature.celsius = 25
let Japan = Country(temperature: temperature)
temperature.celsius = 40
let Egypt = Country(temperature: temperature)
print(Japan.temperature.celsius)
print(Egypt.temperature.celsius)


// コピーオンライト
var array1 = [1,2,3]
var array2 = array1
array1.append(4) //　このタイミングでコピーが作成される
print(array1)
print(array2)


// クラスを利用すべき時
// ・参照を共有する必要があるとき
// ・インスタンスのライフサイクルに合わせて処理を実行するとき
protocol Target {
    var identifier: String{
        get
        set
    }
    var count: Int{
        get
        set
    }
    mutating func action() -> Void 
}
extension Target {
    mutating func action() -> Void {
        self.count += 1
        print("id: \(self.identifier), count: \(self.count)")
    }
}
struct ValueTypeTarget: Target {
    var identifier = "Value Type"
    var count = 0
    init(){
    }
}
class ReferenceTypeTarget: Target {
    var identifier: String = "Reference Type"
    var count: Int = 0
}
struct Timer {
    var target: Target
    mutating func start() -> Void {
        for _ in 0..<5{
            self.target.action()
        }
    }
}
// 構造体のターゲットを登録してタイマーを実行
let valueTypeTarget: Target = ValueTypeTarget()
var timer1 = Timer(target: valueTypeTarget)
timer1.start()
print(valueTypeTarget.count)

// クラスのターゲットを登録してタイマーを実行
let referenceTypeTarget = ReferenceTypeTarget()
var timer2 = Timer(target: referenceTypeTarget)
timer2.start()
print(referenceTypeTarget.count)



// インスタンスのライフサイクルに合わせて処理を実行する
// デイニシャライザを使用したい時はクラスを使用する
var temporaryData: String?
class SomeClass {
    init(){
        print("Create a temporary data")
        temporaryData = "a temporary data"
    }
    deinit{
        print("Clean up the temporary data")
        temporaryData = nil
    }
}
var someClass: SomeClass? = SomeClass()
print(temporaryData)
someClass = nil
print(temporaryData)


// クラスの継承に対すりプロトコルの優位性
// moveメソッドの多様性が実現されている
// 実装せずともsleepメソッドを利用できる
// 抽象的な概念であるAnimalのインスタンス化が可能になってしまっている
// 野生であるためownerプロパティが不要であるWildEagleクラスにもownerプロパティが追加されてしまっている
class Animal {
    var owner: String?
    func sleep () -> Void {
        print("Sleeping")
    }
    func move() -> Void {
    }
}
class Dog: Animal {
    override func move() -> Void {
        print("Running")
    }
}
class Cat: Animal {
    override func move() -> Void {
        print("Prancing")
    }
}
class WildEagle: Animal {
    override func move() -> Void {
        print("Flying")
    }
}

// プロトコルで上記問題を解決
protocol Ownable {
    var owner: String{
        get 
        set
    }
}
protocol Animal {
    func sleep() -> Void 
    func move() -> Void  // moveメソッドの多様性
}
extension Animal {
    func sleep() -> Void { //　実装せずともsleepメソッドを使用できる
        print("Sleeping")
    }
}
struct Dog: Animal, Ownable {
    var owner: String
    func move() -> Void {
        print("Running")
    }
}
struct Cat: Animal, Ownable {
    var owner: String
    func move() -> Void {
        print("Prancing")
    }
}
struct WildEagle: Animal {
    func move() -> Void {
        print("Flying")
    }
}
// 継承できない構造体を推奨されている以上、プロトコルの利用が主流


// クラスの継承を利用すべきとき
// 複数の型の間でストアドプロパティの実装を共有する
class Animal {
    var owner: String?{
        didSet{
            guard let owner = owner else {
                return
            }
            print("\(self.owner) was assigned as the owner")
        }
    }
}
class Dog: Animal {
}
class Cat: Animal {
}
class WildEagle: Animal {
}
let dog = Dog()
dog.owner = "Taro"
let cat = Cat() 
print(cat.owner)

// 複数の型の間でプロパティの実装の共有をプロトコル＋構造体で実装しようとすると以下のよう
// プロパティオブザーバやストアドプロパティの実装をそれぞれの構造体でする必要がある
protocol Ownable {
    var owner: String{
        get 
        set 
    }
}
struct Dog: Ownable {
    var owner: String{
        didSet{
            print("\(self.owner) was assigned as the owner")
        }
    }
}
struct Cat: Ownable {
    var owner : String{
        didSet{
            print("\(self.owner) was assigned as the owner")
        }
    }
}
var dog = Dog(owner: "Suzuki")
var cat = Cat(owner: "Suzuki") 
dog.owner = "Ichiro"
print(cat.owner)
// 同じ実装をそれぞれでする必要があるので非常に冗長


// オプショナル型を利用すべきとき
// 値の不在が想定されるとき
struct User {
    let id: Int
    let name: String
    let mailAddress: String? //メールアドレスを持っていない可能性がある

    init(json: [String: Any]){
    }
}

// 値を必ず持っている箇所をオプショナル型にしてしまうと、、、
struct User {
    let id: Int?
    let name: String?
    let mailAddress: String? //メールアドレスを持っていない可能性がある

    init(json: [String: Any]){
        self.id = json["id"] as? Int
        self.name = json["name"] as? String
        self.mailAddress = json["mailAddress"] as? String
    }
}
let json = [
    "id": 123,
    "name": "Taro"
]
let user = User(json: json)
// 使用する時にいちいちnilを考慮しなければならない
if let id = user.id, let name = user.name {
    print("id:\(id), name:\(name)")
}else{
    print("invalid json")
}

// nilの検証は失敗可能イニシャライザですべき
struct User {
    let id: Int
    let name: String
    let mailAddress: String? //メールアドレスを持っていない可能性がある

    init?(json: [String: Any]){
        guard let id = json["id"] as? Int,
        let name = json["name"] as? String else {
            // idやnameを初期化できなかった場合はインスタンスの初期化が失敗する
            return nil
        }
        self.id = id
        self.name = name
        self.mailAddress = json["email"] as? string
    }
}
let json = [
    "id": 123,
    "name": "Taro"
]
if let user = User(json: json) {
    print("id:\(user.id), name:\(user.name)")
}else {
    // 不正なインスタンスは初期化の時点で検出される
    print("invalid json")
}



// 暗黙的にアンラップされたオプショナル型を利用するべきとき
// ・初期化時にのみ値が決まっていない
@IBOutlet weak var someLabel: UIlabel!
// オプショナル・バインディングを使う場合
if let label = someLabel {
    label.text
}
// 強制アンラップを使用する場合
someLabel!.text

// ・サブクラスの初期化より前にスーパークラスの初期化が必要なとき
class SuperClass {
    let one = 1
}
class BaseClass: SuperClass {
    // let two: Int
    
    // override init() {
    // // self.two = self.one + 1
    // // super.init() //superclassを初期化する前にself.oneにアクセスしようとするためコンパイルエラー

    // // super.init()
    // // self.two = self.one + 1 //superclassの初期化以前にbaseclassのプロパティが初期化されていないためコンパイルエラー　
    // }

    var two: Int!

    override init() {
    super.init()
    two = one + 1
    }
}


