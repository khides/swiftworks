// // ・while文
var nextvalue = Optional(1)
while case let value? = nextvalue{
    print("value: \(value)")
    print(type(of: value))
    if value > 3{
        nextvalue = nil
    }else{
        nextvalue = value+1
    }
}
