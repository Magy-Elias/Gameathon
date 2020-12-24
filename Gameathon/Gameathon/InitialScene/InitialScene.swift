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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        let node = self.atPoint(location)
        
        if (node.name == "yllaNl3b") {
            
            // navigate to track screen
            guard let mainScene = MainScene(fileNamed: "MainScene") else { return }
            self.view?.presentScene(mainScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
        }
    }
}

