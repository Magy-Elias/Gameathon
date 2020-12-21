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
    
//    var firstImage = SKSpriteNode(imageNamed: "firstImage")
//    var secondImage = SKSpriteNode(imageNamed: "secondImage")
//    var playBtn = SKSpriteNode(imageNamed: "playBtn")
//    var backBtn = SKSpriteNode(imageNamed: "backBtn")
    var scoreLabel = SKLabelNode()
    var player: AVAudioPlayer?
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    

    override func didMove(to view: SKView) {
        
        //        firstImage = self.childNode(withName: "firstImage") as! SKSpriteNode
        //        secondImage = self.childNode(withName: "secondImage") as! SKSpriteNode
        //        playBtn = self.childNode(withName: "playBtn") as! SKSpriteNode
//        secondImage.isUserInteractionEnabled = true
        
        
        // score label
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
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

        if (node.name == "firstImage") {
            playSound(fileName: "cheer")
            score += 1
            scoreLabel.text = "Score: \(score)"
            
        } else if (node.name == "secondImage") {
            playSound(fileName: "wrongAnswer")
            if score > 0 {
                score -= 1
                scoreLabel.text = "Score: \(score)"
            } else {
                score = 0
                scoreLabel.text = "Score: \(score)"
            }

        } else if (node.name == "playBtn") {
            playSound(fileName: "verse")
            
        } else if (node.name == "backBtn") {
            // back to home page
//            ACTManager.shared.transtion(self, toScene: .MainScene, transtion: SKTransition.moveIn(with: .right, duration: 0.5))
            guard let mainScene = MainScene(fileNamed: "MainScene") else { return }
            self.view?.presentScene(mainScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
        }
        
        UserDefaults.standard.set(score, forKey: "score")
    }

    
    func playSound(fileName: String) {
        let url = Bundle.main.url(forResource: fileName, withExtension: "mp3")!

        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }

            player.prepareToPlay()
            player.play()

        } catch let error as NSError {
            print(error.description)
        }
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
        playerHasFinished = true
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        displayGameOver()
//    }
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
