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
    
    let emitter = SKEmitterNode(fileNamed: "MyParticle")
    let colors = [SKColor.white, SKColor.yellow, SKColor.magenta ,SKColor.cyan]

    
//    var score = 0 {
//        didSet {
//            scoreLabel.text = "Score: \(score)"
//        }
//    }
    

    override func didMove(to view: SKView) {
        
//        verseAudioNode = SKAudioNode(fileNamed: "")
//         verseAudioNode.isPositional = false
//         self.addChild(verseAudioNode)
//         verseAudioNode.run(SKAction.play())
//         
//         let sequence = SKAction.sequence([SKAction.wait(forDuration: 10)])
//         verseAudioNode.run(sequence, completion: {
//             self.verseAudioNode.removeFromParent()
//         })
        
        // score label
        score = UserDefaults.standard.integer(forKey: "score")
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontColor = .red
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: self.frame.midX + 110, y: 150)
//        addChild(scoreLabel)
  
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

                self.emitParticles()
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
            verseAudioNode = SKAudioNode(fileNamed: "verse.mp3")
            verseAudioNode.isPositional = false
            self.addChild(verseAudioNode)
            verseAudioNode.run(SKAction.play())
            
            let sequence = SKAction.sequence([SKAction.wait(forDuration: 10.6)])
            verseAudioNode.run(sequence, completion: {
                self.verseAudioNode.removeFromParent()
            })
            
        } else if (node.name == "backBtn") {
            guard let levelsScene = LevelsScene(fileNamed: "LevelsScene") else { return }
            self.view?.presentScene(levelsScene, transition: SKTransition.moveIn(with: .left, duration: 0.5))
            
        } else if (node.name == "homeBtn") {
            
            // navigate to selection track screen
            guard let selectionScene = SelectionScene(fileNamed: "SelectionScene") else { return }
            self.view?.presentScene(selectionScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
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
    
    func emitParticles() {
  
        emitter?.position = CGPoint(x: 0.5, y: 0.5)
        emitter?.particleColorSequence = nil
        emitter?.particleColorBlendFactor = 2.0

        self.addChild(emitter!)

        let action = SKAction.run({
            [unowned self] in
            let random = Int(arc4random_uniform(UInt32(self.colors.count)))

            self.emitter?.particleColor = self.colors[random];  //SKColor.yellow 
        })

        let wait = SKAction.wait(forDuration: 0.1)

        self.run(SKAction.repeatForever( SKAction.sequence([action,wait])))

    }
}


class GameOverScene: SKScene {

    var notificationLabel = SKLabelNode(text: "Level ended")

    override init(size: CGSize) {
        super.init(size: size)

        self.backgroundColor = SKColor.init(hex: "#003F65") ?? SKColor.darkGray

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
        guard let levelsScene = LevelsScene(fileNamed: "LevelsScene") else { return }
        self.view?.presentScene(levelsScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        let gameScene = VersesScene(size: size)
        gameScene.scaleMode = scaleMode

        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        view?.presentScene(gameScene, transition: reveal)
    }
}


extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 7 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
