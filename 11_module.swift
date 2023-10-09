// アクセスコントロール
// モジュール外から使用可能な型
open class SomeOpenClass {
}

// モジュール外から使用可能だが、モジュール外で継承不可能な型
public class SomePublicClass {
    // モジュール内でのみ使用可能なプロパティ
    internal let someInternalConstant = 1

    // 同一ソースファイル内でのみ使用可能なプロパティ
    fileprivate var someFileprivateVariable = 1

    // クラス内でのみ使用可能なメソッド
    private func somePrivateMethod() -> Void {
    }
}


// デフォルトのアクセスレベル
public struct SomeStruct {
    // デフォルトではinternalなので、モジュール外からは見えない
    var idInternal: Int
    func someMethodInternal() -> Void {
    }
}

// エクステンションのアクセスレベル
extension SomeStruct {
    private var a: Int
    private var b: Int
}
extension SomeStruct: Equatable {
    static func ==(_ lhs: SomeStruct, _ rhs: SomeStruct) -> Bool {
        return lhs.a == rhs.a && lhs.b == rhs.b
    }
}


///　ドキュメントコメント　Markdown記法でQuickHelpに反映させる
/** 複数行のドキュメントコメント
* **太文字**
* [リンク]
*
**/

/** メソッドの説明です
* -parameter arg1: 第一引数の説明
* -parameter arg2: 第二引数の説明
* -returns: 戻り値の説明
* -throws: エラーの説明
*/
func someMethod(arg1: String, arg2: String) -> Void {
}