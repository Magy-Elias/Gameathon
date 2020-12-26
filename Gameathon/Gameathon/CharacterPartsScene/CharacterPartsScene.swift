//
//  CharacterPartsScene.swift
//  Gameathon
//
//  Created by Samar Younan on 12/25/20.
//  Copyright © 2020 MagyElias. All rights reserved.
//

import Foundation
import SpriteKit

class CharacterPartsScene: SKScene {
    
    var hintAudioNode = SKAudioNode()
    var isFromBack = false
    
    override func didMove(to view: SKView) {
        
        if !isFromBack {
            hintAudioNode = SKAudioNode(fileNamed: "YllaE5tarQssa")
            hintAudioNode.isPositional = false
            self.addChild(hintAudioNode)
            hintAudioNode.run(SKAction.play())
            
            let sequence = SKAction.sequence([SKAction.wait(forDuration: 6)])
            hintAudioNode.run(sequence, completion: {
                self.hintAudioNode.removeFromParent()
            })
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let touch = touches.first else {
            return
        }

        let location = touch.location(in: self)
        let node = self.atPoint(location)

        if (node.name == "elbsharaEntry") {
            // navigate to characters track screen
            guard let levelsScene = LevelsScene(fileNamed: "LevelsScene") else { return }
            let transition = SKTransition.moveIn(with: .right, duration: 1)
            self.view?.presentScene(levelsScene, transition: transition)
            
        } else if (node.name == "homeBtn") {
            guard let selectionScene = SelectionScene(fileNamed: "SelectionScene") else { return }
            self.view?.presentScene(selectionScene, transition: SKTransition.moveIn(with: .left, duration: 0.5))
            
        } else if (node.name == "backBtn") {
            guard let charactersTrackScene = CharactersTrackScene(fileNamed: "CharactersTrackScene") else { return }
            charactersTrackScene.isFromBack = true
            self.view?.presentScene(charactersTrackScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
            
        } else if (node.name == "homeBtn") {
            guard let selectionScene = SelectionScene(fileNamed: "SelectionScene") else { return }
//            selectionScene.isFromBack = true
            self.view?.presentScene(selectionScene, transition: SKTransition.moveIn(with: .left, duration: 0.5))
            
        }
    }
}
