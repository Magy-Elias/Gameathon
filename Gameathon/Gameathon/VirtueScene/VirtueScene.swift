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
    var isFirstTouch = 0
    let bravoNode = SKSpriteNode(texture: SKTexture(imageNamed: "great2"))
    let smileNNode = SKSpriteNode(texture: SKTexture(imageNamed: "smile"))
    let sadNNode = SKSpriteNode(texture: SKTexture(imageNamed: "sad"))
    
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
            
        } else if (node.name == "mute") {
            
            if isFirstTouch % 2 == 0 {
                hintAudioNode.run(SKAction.changeVolume(to: Float(0), duration: 0))
                self.isFirstTouch += 1
                (node as? SKSpriteNode)?.texture = SKTexture(imageNamed:"playBtn")
                
            } else {
                hintAudioNode.run(SKAction.changeVolume(to: Float(1), duration: 0))
                self.isFirstTouch += 1
                (node as? SKSpriteNode)?.texture = SKTexture(imageNamed:"mute")
            }
        } else if (node.name == "homeBtn") {
            // navigate to selection track screen
            guard let selectionScene = SelectionScene(fileNamed: "SelectionScene") else { return }
            //            selectionScene.isFromBack = true
            self.view?.presentScene(selectionScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
            
        } else if (node.name == "red") {
            
            smileNNode.removeFromParent()
            sadNNode.removeFromParent()
            
            bravoNode.zPosition = 1
            bravoNode.size = CGSize(width: 150, height: 100)
            bravoNode.position = CGPoint(x: -59, y: 80)
            self.addChild(bravoNode)
            animateNodesWithTwist([bravoNode])
            
        } else if (node.name == "blue") {
            
            bravoNode.removeFromParent()
            sadNNode.removeFromParent()

            smileNNode.zPosition = 1
            smileNNode.size = CGSize(width: 150, height: 80)
            smileNNode.position = CGPoint(x: -59, y: 122)
            self.addChild(smileNNode)
            animateNodes([smileNNode])
            
        } else if (node.name == "yellow") {
            
            bravoNode.removeFromParent()
            smileNNode.removeFromParent()

            sadNNode.zPosition = 1
            sadNNode.size = CGSize(width: 150, height: 80)
            sadNNode.position = CGPoint(x: -59, y: 122)
            self.addChild(sadNNode)
            animateNodes([sadNNode])
        }
    }
}


extension VirtueScene {
    func animateNodes(_ nodes: [SKNode]) {
        for (index, node) in nodes.enumerated() {
            node.run(.sequence([
                .wait(forDuration: TimeInterval(index) * 0.2),
                .repeatForever(.sequence([
                    .scale(to: 1.5, duration: 0.3),
                    .scale(to: 1, duration: 0.3),
                    .wait(forDuration: 2)
                ]))
            ]))
        }
    }
}


extension VirtueScene {
    
    func animateNodesWithTwist(_ nodes: [SKNode]) {
        for (index, node) in nodes.enumerated() {
            node.run(.sequence([
                .wait(forDuration: TimeInterval(index) * 0.2),
                .repeatForever(.sequence([
                    // A group of actions get performed simultaneously
                    .group([
                        .sequence([
                            .scale(to: 1.5, duration: 0.3),
                            .scale(to: 1, duration: 0.3)
                        ]),
                        // Rotate by 360 degrees (pi * 2 in radians)
                        .rotate(byAngle: .pi * 2, duration: 0.6)
                    ]),
                    .wait(forDuration: 2)
                ]))
            ]))
        }
    }
}
