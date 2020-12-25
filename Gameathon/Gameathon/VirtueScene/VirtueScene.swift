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
    
    override func didMove(to view: SKView) {
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
             return
         }
         
         let location = touch.location(in: self)
         let node = self.atPoint(location)

        if (node.name == "backBtn") {
            guard let levelsScene = LevelsScene(fileNamed: "LevelsScene") else { return }
            self.view?.presentScene(levelsScene, transition: SKTransition.moveIn(with: .left, duration: 0.5))
            
        } else if (node.name == "homeBtn") {
            
            // navigate to selection track screen
            guard let selectionScene = SelectionScene(fileNamed: "SelectionScene") else { return }
            self.view?.presentScene(selectionScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
        }
    }    
}
