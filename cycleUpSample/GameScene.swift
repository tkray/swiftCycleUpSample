//
//  GameScene.swift
//  cycleUpSample
//
//  Created by Yuuki.Takara on 2015/10/08.
//  Copyright (c) 2015年 Yuu. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var initiated: Bool = false
    
    var last:CFTimeInterval!
    
    // sceneが起動した時に呼ばれるメソッド
    override func didMoveToView(view: SKView) {
        //初期化時のみ実行
        if !initiated {
            self.initContent()
            self.initiated = true
        }
    }
    
    // 画面をタップされた時に呼ばれるメソッド
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {}
    
    
    // 最初の1回だけ呼ばれるメソッド
    func initContent() {
        // 全体の背景色を設定
        self.backgroundColor = UIColor.hex("#FFFFFF", alpha: 1)
        // 真ん中のタイトルを作成
        var label = self.centerTitleNode()
        // sceneにタイトルを追加
        self.addChild(label)
    }
    
    
    // 真ん中に表示するタイトルを作成するメソッド
    func centerTitleNode(Void) -> SKLabelNode {
        // 表示するタイトル
        var helloNode = SKLabelNode(text: "Cycle UP!")
        // 文字色の設定
        helloNode.fontColor = UIColor.hex("#000000", alpha: 0.8)
        // 文字の大きさ
        helloNode.fontSize = 60
        // 表示位置
        helloNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        // 円よりも前面に表示する
        helloNode.zPosition = 1
        
        return helloNode
    }
    
    
    // 円を追加するメソッド
    func addShape() {
        // 画面の横幅をUInt32で取得（乱数を発生させる際にUInt32だから）
        let displayWidth : UInt32 = UInt32(self.view!.frame.width)
        
        // 画面サイズまでの乱数を生成する
        // iPhone6の場合（1~375）まで
        var randomWidth = arc4random_uniform(displayWidth) + 1
        
        // 円を表示する位置
        var location = CGPoint()
        location.x = CGFloat(randomWidth)
        location.y = CGRectGetMinY(self.frame)
    
        println("追加するよ")
        
        var randomCycleWidth : Int = Int(arc4random() % 40) + 10
        
        println("randomCycleWidth：\(randomCycleWidth)")
        
        // 円の大きさ
        var size : CGFloat = CGFloat(randomCycleWidth)
        // 円を作成
        let shape = SKShapeNode(circleOfRadius: size)
        //let shape = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(40, 40))
        
        // 円の色
        shape.fillColor = UIColor.hex("#E3E3E3", alpha: 1)
        // 円の表示位置
        shape.position = location
        // タイトルよりも背面に表示する
        shape.zPosition = 0
        
        // 物理的な性質を持たせる
        shape.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(size, size))
        // 重力の影響を受けないようにする
        shape.physicsBody?.affectedByGravity = false
        // 移動速度（Y方向に移動する）
        shape.physicsBody?.velocity = CGVectorMake(0, 200)
        // 空気抵抗をなくす
        shape.physicsBody?.linearDamping = 0
        
        // 画面に円を追加
        self.addChild(shape)
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        
        // lastが未定義ならば、今の時間を入れる。
        if last == nil {
            last = currentTime
        }
        
        // 1秒おきに行う処理をかく。
        if last + 1 <= currentTime {
            
            // 円を追加する
            self.addShape()
            last = currentTime
        }
    }
}
