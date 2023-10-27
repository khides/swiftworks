// デリゲートパターン
protocol GameDelegate: class { //プレイヤーの人数とゲームの開始、ゲームの終了の処理を委譲するためのインターフェース
    var numberOfPlayers: Int{
        get 
    }
    func gameDidStart(_ game: Game) -> Void 
    func gameDidEnd(_ game: Game ) -> Void 
}
class TwoPersonsGameDelegate: GameDelegate {
    var numberOfPlayers: Int{
        return 2
    }
    func gameDidStart(_ game: Game ) -> Void {
        print("Game start")
    }
    func gameDidEnd(_ game: Game ) -> Void {
        print("Game end")
    }
}
class Game {
    weak var delegate: GameDelegate?
    // ディゲート先のオブジェクトとデリゲート元のオブジェクトが互いに参照し合って、メモリを圧迫する恐れがある
    // 通常デリゲート元からデリゲート先への参照を弱参照とする
    func start() -> Void {
        print("number of players is \(self.delegate?.numberOfPlayers ?? 1)") //デリゲート先にプレイヤーの人数を問い合わせる
        delegate?.gameDidEnd(self)
        print("playing")
        delegate?.gameDidEnd(self)
    }
}
let delegate = TwoPersonsGameDelegate()
let twoPersonsGame = Game()
twoPersonsGame.delegate = delegate
twoPersonsGame.start()
// 利用するべきとき
// ・非同期処理を開始したタイミングで、プログレスバーを表示する
// ・非同期処理の途中で、定期的にプログレスバーを更新する
// ・非同期処理が完了したタイミングで、エラーダイアログを表示する



// クロージャの利用
class Game {
    private var result = 0
    func start(completion: (Int) -> Void) -> Void {
        print("Playing")
        result = 42
        completion(result)
    }
}
let game = Game()
game.start{result in 
    print("Result is \(result)")
}

// キャプチャリスト
import PlaygroundSupport
import Dispatch

PlaygroundPage.current.needsIndefiniteExecution = true

class SomeClass {
    let id: Int
    init(id: Int){
        self.id = id
    }
    deinit{
        print("deinit") //解放
    }
}
do{
    let object = SomeClass(id: 42)
    let queue = DispatchQueue.main
    queue.asyncAfter(deadline: .now+3, execute: {print(object.id)}) //三秒後までクラスのインスタンスが生存->解放
}


