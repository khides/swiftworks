
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