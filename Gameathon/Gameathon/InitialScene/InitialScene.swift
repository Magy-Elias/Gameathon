//
//  initialScene.swift
//  Gameathon
//
//  Created by Samar Younan on 12/24/20.
//  Copyright © 2020 MagyElias. All rights reserved.
//

import Foundation
import SpriteKit

class InitialScene: SKScene {
    
    let f0 = SKTexture.init(imageNamed: "Intro – 1")
    let f1 = SKTexture.init(imageNamed: "Intro – 2")
    let f2 = SKTexture.init(imageNamed: "Intro – 3")
    let f3 = SKTexture.init(imageNamed: "Intro – 4")
   var introNode = SKSpriteNode(imageNamed: "Intro – 1")

    
    override func didMove(to view: SKView) {
        // Load the first frame as initialization
         let frames: [SKTexture] = [f0, f1, f2, f3]
        introNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        introNode.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)

        // Change the frame per 0.2 sec
        let animation = SKAction.animate(with: frames, timePerFrame: 0.4)
        introNode.run(SKAction.repeatForever(animation))

        self.addChild(introNode)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        let node = self.atPoint(location)
        
        if (node.name == "yllaNl3bBtn") {
            // navigate to selection track screen
            guard let selectionScene = SelectionScene(fileNamed: "SelectionScene") else { return }
            self.view?.presentScene(selectionScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
            
        } else if (node.name == "homeBtn") {
            guard let selectionScene = SelectionScene(fileNamed: "SelectionScene") else { return }
            selectionScene.isFromBack = true
            self.view?.presentScene(selectionScene, transition: SKTransition.moveIn(with: .left, duration: 0.5))
            
        }
    }
}

