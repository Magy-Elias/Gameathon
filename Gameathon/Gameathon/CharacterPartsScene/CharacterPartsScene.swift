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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let touch = touches.first else {
            return
        }

        let location = touch.location(in: self)
        let node = self.atPoint(location)

        if (node.name == "elbsharaEntry") {
            // navigate to characters track screen
            guard let levelsScene = LevelsScene(fileNamed: "LevelsScene") else { return }
            let transition = SKTransition.doorway(withDuration: 1)
            self.view?.presentScene(levelsScene, transition: transition)
        }
    }
}
