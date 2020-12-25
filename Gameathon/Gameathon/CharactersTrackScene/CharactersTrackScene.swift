//
//  CharactersTrackScene.swift
//  Gameathon
//
//  Created by Samar Younan on 12/24/20.
//  Copyright © 2020 MagyElias. All rights reserved.
//

import Foundation
import SpriteKit

class CharactersTrackScene: SKScene {
    
    var score: Int = 0

    override func didMove(to view: SKView) {
        
        self.score = UserDefaults.standard.integer(forKey: "score")
 
        if self.score > 5 && self.score <= 10 {
           
            rateOneStar()
            
        } else if self.score > 10 && self.score <= 20 {
            
            rateTwostars()
            
        } else if self.score > 20 {
            
            rateThreestars()
        }
    }
    
    func rateOneStar() {
        for node in self.children {
            if node.name == "star1" {
                node.removeFromParent()
            }
        }
        let newStarOne = SKSpriteNode(texture: SKTexture(imageNamed: "star3"))
        newStarOne.position = CGPoint(x: -275, y: -42)
        newStarOne.size = CGSize(width: 51, height: 49)
        newStarOne.zPosition = 4
        self.addChild(newStarOne)
    }
    
    func rateTwostars() {
        for node in self.children {
            if node.name == "star1" || node.name == "star2" {
                node.removeFromParent()
            }
        }
        let newStarOne = SKSpriteNode(texture: SKTexture(imageNamed: "star3"))
        newStarOne.position = CGPoint(x: -275, y: -42)
        newStarOne.size = CGSize(width: 51, height: 49)
        newStarOne.zPosition = 4
        self.addChild(newStarOne)
        
        let newStarTwo = SKSpriteNode(texture: SKTexture(imageNamed: "star3"))
        newStarTwo.position = CGPoint(x: -225, y: -42)
        newStarTwo.size = CGSize(width: 51, height: 49)
        newStarTwo.zPosition = 4
        self.addChild(newStarTwo)
        
    }
    
    func rateThreestars() {
        
        for node in self.children {
            if node.name == "star1" || node.name == "star2" || node.name == "star3" {
                node.removeFromParent()
            }
        }
        
         let newStarOne = SKSpriteNode(texture: SKTexture(imageNamed: "star3"))
         newStarOne.position = CGPoint(x: -275, y: -42)
         newStarOne.size = CGSize(width: 51, height: 49)
         newStarOne.zPosition = 4
         self.addChild(newStarOne)
         
         let newStarTwo = SKSpriteNode(texture: SKTexture(imageNamed: "star3"))
         newStarTwo.position = CGPoint(x: -225, y: -42)
         newStarTwo.size = CGSize(width: 51, height: 49)
         newStarTwo.zPosition = 4
         self.addChild(newStarTwo)
         
        let newStarThree = SKSpriteNode(texture: SKTexture(imageNamed: "star3"))
        newStarThree.position = CGPoint(x: -175, y: -42)
        newStarThree.size = CGSize(width: 51, height: 49)
        newStarThree.zPosition = 4
        self.addChild(newStarThree)
     }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        let node = self.atPoint(location)
        
        if (node.name == "mamaEl3adra") {
            // navigate to characters track screen
            guard let mamaEl3adraScene = MamaEl3adraScene(fileNamed: "MamaEl3adraScene") else { return }
            self.view?.presentScene(mamaEl3adraScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
            
        } else if (node.name == "homeBtn") {
            guard let selectionScene = SelectionScene(fileNamed: "SelectionScene") else { return }
            self.view?.presentScene(selectionScene, transition: SKTransition.moveIn(with: .left, duration: 0.5))
            
        }
    }
}
