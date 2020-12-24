//
//  GameScene.swift
//  Gameathon
//
//  Created by Samar Younan on 12/18/20.
//  Copyright © 2020 Samar Younan. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class VersesScene: SKScene {
    
    var notificationLabel = SKLabelNode(text: "Tap the screen")
    var playerHasFinished = false
    var scoreLabel = SKLabelNode()
    var player: AVAudioPlayer?
    var score = 0
    var touching = true
    var imageIsSelected = false
    var verseAudioNode = SKAudioNode()
    
//    var score = 0 {
//        didSet {
//            scoreLabel.text = "Score: \(score)"
//        }
//    }
    

    override func didMove(to view: SKView) {
        
        // score label
        score = UserDefaults.standard.integer(forKey: "score")
            
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontColor = .red
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: self.frame.midX + 110, y: 150)
        addChild(scoreLabel)
  
        // game over
        self.backgroundColor = SKColor.black
        addChild(notificationLabel)
        notificationLabel.fontSize = 32.0
        notificationLabel.color = SKColor.white
        notificationLabel.fontName = "Thonburi-Bold"
        notificationLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
    }
    
    func displayGameOver() {

        let gameOverScene = GameOverScene(size: size)
        gameOverScene.scaleMode = scaleMode

        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        view?.presentScene(gameOverScene, transition: reveal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        let node = self.atPoint(location)

        if self.touching {
            if (node.name == "firstImage") {
                self.imageIsSelected = true

                score += 1
                scoreLabel.text = "Score: \(score)"

                let cheerAudioNode = SKAudioNode(fileNamed: "cheer.mp3")
                cheerAudioNode.isPositional = false
                self.addChild(cheerAudioNode)
                cheerAudioNode.run(SKAction.play())
                self.verseAudioNode.run(SKAction.stop())
                let sequence = SKAction.sequence([SKAction.wait(forDuration: 4)])
                cheerAudioNode.run(sequence, completion: {
                    cheerAudioNode.removeFromParent()
                    self.displayGameOver()
                })
                
            } else if (node.name == "secondImage") {
                
                self.imageIsSelected = true
                if score > 0 {
                    score -= 1
                    scoreLabel.text = "Score: \(score)"
                } else {
                    score = 0
                    scoreLabel.text = "Score: \(score)"
                }
                
                let wrongAnswerAudioNode = SKAudioNode(fileNamed: "wrongAnswer.mp3")
                wrongAnswerAudioNode.isPositional = false
                self.addChild(wrongAnswerAudioNode)
                wrongAnswerAudioNode.run(SKAction.play())
                self.verseAudioNode.run(SKAction.stop())
                let sequence = SKAction.sequence([SKAction.wait(forDuration: 2)])
                wrongAnswerAudioNode.run(sequence, completion: {
                    wrongAnswerAudioNode.removeFromParent()
                    self.displayGameOver()
                })
            }
        }
        
        if (node.name == "playBtn") {
            
            self.verseAudioNode.run(SKAction.stop())
            verseAudioNode = SKAudioNode(fileNamed: "verse1.mp3")
            verseAudioNode.isPositional = false
            self.addChild(verseAudioNode)
            verseAudioNode.run(SKAction.play())
            
        } else if (node.name == "backBtn") {
            guard let mainScene = MainScene(fileNamed: "MainScene") else { return }
            self.view?.presentScene(mainScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
        }
        
        UserDefaults.standard.set(score, forKey: "score")
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.imageIsSelected {
            self.touching = false
        }
    }
}


class GameOverScene: SKScene {

    var notificationLabel = SKLabelNode(text: "Level ended")

    override init(size: CGSize) {
        super.init(size: size)

        self.backgroundColor = SKColor.darkGray

        addChild(notificationLabel)
        notificationLabel.fontSize = 32.0
        notificationLabel.color = SKColor.white
        notificationLabel.fontName = "Thonburi-Bold"
        notificationLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let mainScene = MainScene(fileNamed: "MainScene") else { return }
        self.view?.presentScene(mainScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        let gameScene = VersesScene(size: size)
        gameScene.scaleMode = scaleMode

        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        view?.presentScene(gameScene, transition: reveal)
    }
}
