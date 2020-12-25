//
//  CharactersScene.swift
//  Gameathon
//
//  Created by Samar Younan on 12/24/20.
//  Copyright © 2020 MagyElias. All rights reserved.
//

import Foundation
import SpriteKit

class SelectionScene: SKScene {
    
    override func didMove(to view: SKView) {

//        let firstNode = SKSpriteNode(texture: SKTexture(imageNamed: "Group 943"))
//        firstNode.position = CGPoint(x: 139, y: 18)
//        firstNode.size = CGSize(width: 118, height: 142)
//        self.addChild(firstNode)
//        
//        let secondNode = SKSpriteNode(texture: SKTexture(imageNamed: "Group 943"))
//        secondNode.position = CGPoint(x: 250, y: 46)
//        secondNode.size = CGSize(width: 80, height: 98)
//        self.addChild(secondNode)
//        
//        let thirdNode = SKSpriteNode(texture: SKTexture(imageNamed: "Group 943"))
//        thirdNode.position = CGPoint(x: 320, y: 65)
//        thirdNode.size = CGSize(width: 116, height: 135)
//        self.addChild(thirdNode)
//        
//        let fourthNode = SKSpriteNode(texture: SKTexture(imageNamed: "Group 943"))
//        fourthNode.position = CGPoint(x: 80, y: 33)
//        fourthNode.size = CGSize(width: 118, height: 142)
//        self.addChild(fourthNode)
        
//        let storyNode = SKSpriteNode(texture: SKTexture(imageNamed: "7adota"))
//        storyNode.position = CGPoint(x: 151, y: 46)
//        storyNode.size = CGSize(width: 143, height: 172)
//        self.addChild(storyNode)
//        
//        let charactersNode = SKSpriteNode(texture: SKTexture(imageNamed: "sha5syatIcon"))
//        charactersNode.name = "characters"
//        charactersNode.position = CGPoint(x: -67, y: 25)
//        charactersNode.size = CGSize(width: 143, height: 172)
//        self.addChild(charactersNode)
//        
//        let taqsNode = SKSpriteNode(texture: SKTexture(imageNamed: "taqsIcon"))
//        taqsNode.position = CGPoint(x: 320, y: 107)
//        taqsNode.size = CGSize(width: 118, height: 110)
//        self.addChild(taqsNode)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        let node = self.atPoint(location)
        
        if (node.name == "characters") {
            
            // navigate to characters track screen
            guard let charactersTrackScene = CharactersTrackScene(fileNamed: "CharactersTrackScene") else { return }
            self.view?.presentScene(charactersTrackScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
            
        } else if (node.name == "settings") {
            
            // navigate to characters track screen
            guard let charactersTrackScene = SettingsScene(fileNamed: "SettingsScene") else { return }
            self.view?.presentScene(charactersTrackScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
        }
    }
}
