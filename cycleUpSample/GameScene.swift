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
    
    override func didMoveToView(view: SKView) {
        if ( !initiated ) { //初期化時のみ実行
            self.initContent()
            self.initiated = true
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
    
    func initContent() {
        self.backgroundColor = SKColor.blueColor() // 背景色設定
        var label = self.newHelloNode() // テキストノードの作成
        self.addChild(label) // sceneにテキストノードを追加
        
        
    }
    
    
    func newHelloNode(Void) -> SKLabelNode {
        var helloNode = SKLabelNode(text: "Cycle UP!")
        helloNode.fontColor = UIColor(red: 1.0, green:1.0, blue: 1.0, alpha: 1)
        helloNode.fontSize = 60
        helloNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        
        return helloNode
    }
    
    // 一定の間隔で繰り返しShpaeを追加する
    func alwaysShapeAdd() {
        
    }
    
    
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
        //location.y = CGFloat(n)
    
        
        println("追加するよ")
        
        var size : CGFloat = self.frame.width/30.0
        let shape = SKShapeNode(circleOfRadius: size)
        //let shape = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(40, 40))
        //shape.fillColor = UIColor.whiteColor() // 塗りつぶし設定
        shape.position = location //表示位置設定
        
        // 物理的な性質を持たせる
        shape.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(size, size))
        
        // 重力の影響を受けないようにする
        shape.physicsBody?.affectedByGravity = false
        // 移動速度（Y方向に移動する）
        shape.physicsBody?.velocity = CGVectorMake(0, 200)
        // 空気抵抗をなくす
        shape.physicsBody?.linearDamping = 0
        
        self.addChild(shape) //画面へのオブジェクト追加
    }
    
    func shoot() {
        let square = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(40, 40))
        square.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        square.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(40, 40))
        square.physicsBody?.affectedByGravity = false
        square.physicsBody?.velocity = CGVectorMake(0, 100)
        square.physicsBody?.linearDamping = 0
        self.addChild(square)
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
