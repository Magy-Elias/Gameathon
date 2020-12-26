//
//  VirtueScene.swift
//  Gameathon
//
//  Created by Samar Younan on 12/24/20.
//  Copyright © 2020 MagyElias. All rights reserved.
//

import Foundation
import SpriteKit

class VirtueScene: SKScene {
    
    var hintAudioNode = SKAudioNode()
    
      override func didMove(to view: SKView) {
        
        hintAudioNode = SKAudioNode(fileNamed: "lwKontMakany")
        hintAudioNode.isPositional = false
        self.addChild(hintAudioNode)
        hintAudioNode.run(SKAction.play())

        let sequence = SKAction.sequence([SKAction.wait(forDuration: 8)])
        hintAudioNode.run(sequence, completion: {
            self.hintAudioNode.removeFromParent()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
             return
         }
         
         let location = touch.location(in: self)
         let node = self.atPoint(location)

        if (node.name == "backBtn") {
            guard let levelsScene = LevelsScene(fileNamed: "LevelsScene") else { return }
            levelsScene.isFromBack = true
            self.view?.presentScene(levelsScene, transition: SKTransition.moveIn(with: .left, duration: 0.5))
            
        } else if (node.name == "homeBtn") {
            
            // navigate to selection track screen
            guard let selectionScene = SelectionScene(fileNamed: "SelectionScene") else { return }
//            selectionScene.isFromBack = true
            self.view?.presentScene(selectionScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
        }
    }    
}
