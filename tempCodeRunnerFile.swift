
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
