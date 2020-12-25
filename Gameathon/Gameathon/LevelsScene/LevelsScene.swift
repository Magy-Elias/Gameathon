//
//  LevelsScene.swift
//  Gameathon
//
//  Created by Samar Younan on 12/19/20.
//  Copyright © 2020 Samar Younan. All rights reserved.
//

import Foundation
import SpriteKit

class LevelsScene: SKScene {
    
//    var partOne = SKSpriteNode(imageNamed: "partOne")
//    var partTwo = SKSpriteNode(imageNamed: "partTwo")
//
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
//        addChild(scoreLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        let node = self.atPoint(location)
        
        
        if (node.name == "partOne") {
            
            let youtubeUrl = "https://www.youtube.com/watch?v=v-NU3KQL-MM"
            if let url = URL(string: youtubeUrl), !url.absoluteString.isEmpty {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        } else if (node.name == "partTwo") {
            guard let versesScene = LevelsScene(fileNamed: "VersesScene") else { return }
            self.view?.presentScene(versesScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
            
        } else if (node.name == "partThree") {
            guard let versesScene = LevelsScene(fileNamed: "CharacterScene") else { return }
            self.view?.presentScene(versesScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
         
            
        } else if (node.name == "partFour") {
            guard let virtueScene = VirtueScene(fileNamed: "VirtueScene") else { return }
            self.view?.presentScene(virtueScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
        
        } else if (node.name == "backBtn") {
            guard let charactersTrackScene = CharacterPartsScene(fileNamed: "CharacterPartsScene") else { return }
            self.view?.presentScene(charactersTrackScene, transition: SKTransition.moveIn(with: .left, duration: 0.5))
        }
    }
}
