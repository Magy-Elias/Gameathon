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
    
    var hintAudioNode = SKAudioNode()
    var isFromBack = false
    
    override func didMove(to view: SKView) {
        
        if !isFromBack {
            hintAudioNode = SKAudioNode(fileNamed: "shar7Ell3ba")
            hintAudioNode.isPositional = false
            self.addChild(hintAudioNode)
            hintAudioNode.run(SKAction.play())
            
            let sequence = SKAction.sequence([SKAction.wait(forDuration: 12)])
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
        
        if (node.name == "characters") {
            
            // navigate to characters track screen
            guard let charactersTrackScene = CharactersTrackScene(fileNamed: "CharactersTrackScene") else { return }
            self.view?.presentScene(charactersTrackScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
            
        } else if (node.name == "settings") {
            
            // navigate to characters track screen
            guard let charactersTrackScene = SettingsScene(fileNamed: "SettingsScene") else { return }
            self.view?.presentScene(charactersTrackScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
            
        }  else if (node.name == "knesty") {
            
            // navigate to characters track screen
            guard let charactersTrackScene = KnestyScene(fileNamed: "KnestyScene") else { return }
            self.view?.presentScene(charactersTrackScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
        }
    }
}
