//
//  SettingsScene.swift
//  Gameathon
//
//  Created by Samar Younan on 12/25/20.
//  Copyright © 2020 MagyElias. All rights reserved.
//

import Foundation
import SpriteKit

class SettingsScene: SKScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        let node = self.atPoint(location)
        
        if (node.name == "backBtn") {
            
            // navigate to selection track screen
            guard let selectionScene = SelectionScene(fileNamed: "SelectionScene") else { return }
            self.view?.presentScene(selectionScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
        }
    }
}
