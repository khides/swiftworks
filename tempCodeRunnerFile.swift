
// 型のネスト 型の中に型を定義できる
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
