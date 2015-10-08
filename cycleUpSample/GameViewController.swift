/* 
参考にさせて頂いたURL：

GameScene・・http://qiita.com/soymsk/items/17ea8c6dc7349a81873b

円が上がっていく・・http://qiita.com/mochizukikotaro/items/6d3a7e445ea67e5b4643

乱数・・http://swift-nyumon.info/random
*/


import UIKit
import SpriteKit


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = self.view as! SKView
        skView.showsFPS = true // FPS表示
        skView.showsNodeCount = true //画面内要素数表示
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let skView = self.view as! SKView
        
        let scene = GameScene(size: skView.bounds.size)
        
        skView.presentScene(scene)
    }
}
