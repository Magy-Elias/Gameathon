//
//  CharacterScene.swift
//  Gameathon
//
//  Created by Samar Younan on 12/19/20.
//  Copyright © 2020 Samar Younan. All rights reserved.
//

import Foundation
import SpriteKit


class CharacterScene: SKScene, SKPhysicsContactDelegate {
    
//    var backBtn = SKSpriteNode(imageNamed: "backBtn")
//
//    var nblaImage = SKSpriteNode(imageNamed: "nbla")
//    var qetharaImage = SKSpriteNode(imageNamed: "qethara")
//    var shabkaImage = SKSpriteNode(imageNamed: "shabka")
//    var sheepImage = SKSpriteNode(imageNamed: "sheep")
//    var unknowImage = SKSpriteNode(imageNamed: "unknown")
    
    var scoreLabel = SKLabelNode()
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    
    override func didMove(to view: SKView) {
        
//        backBtn.isUserInteractionEnabled = true
        
//        nblaImage.physicsBody = SKPhysicsBody(circleOfRadius: nblaImage.size.height / 2)
//        nblaImage.physicsBody?.isDynamic = false
//        nblaImage.physicsBody!.contactTestBitMask = 1
//        nblaImage.physicsBody!.categoryBitMask = 1
//        nblaImage.physicsBody!.collisionBitMask = 1
//
//        unknowImage.physicsBody = SKPhysicsBody(circleOfRadius: unknowImage.size.height / 2)
//        unknowImage.physicsBody!.contactTestBitMask = 2
//        unknowImage.physicsBody!.categoryBitMask = 2
//        unknowImage.physicsBody!.collisionBitMask = 2
        
        // score label
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        score = UserDefaults.standard.integer(forKey: "score")
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontColor = .red
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: self.frame.midX + 110, y: 150)
        addChild(scoreLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        nblaImage.physicsBody?.isDynamic = true
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        let node = self.atPoint(location)
        
        if (node.name == "backBtn") {
            guard let mainScene = MainScene(fileNamed: "MainScene") else { return }
            self.view?.presentScene(mainScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
        }
        
        if (node.name == "nbla") {
            
        }
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("we have contact")
    }
}
