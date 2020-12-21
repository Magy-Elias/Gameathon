//
//  MainScene.swift
//  Gameathon
//
//  Created by Samar Younan on 12/19/20.
//  Copyright © 2020 Samar Younan. All rights reserved.
//

import Foundation
import SpriteKit

class MainScene: SKScene {
    
    var partOne = SKSpriteNode(imageNamed: "partOne")
    var partTwo = SKSpriteNode(imageNamed: "partTwo")
    
    var scoreLabel = SKLabelNode()
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
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
    
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        let node = self.atPoint(location)

        if (node.name == "partOne") {
//            ACTManager.shared.transtion(self, toScene: .VersesScene, transtion: SKTransition.moveIn(with: .right, duration: 0.5))
            guard let versesScene = MainScene(fileNamed: "VersesScene") else { return }
            self.view?.presentScene(versesScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
        } else if (node.name == "partTwo") {
            guard let versesScene = MainScene(fileNamed: "CharacterScene") else { return }
            self.view?.presentScene(versesScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
        }
    }
}
