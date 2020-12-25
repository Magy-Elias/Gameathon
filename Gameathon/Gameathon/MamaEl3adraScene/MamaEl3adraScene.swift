//
//  MamaEl3adraScene.swift
//  Gameathon
//
//  Created by Samar Younan on 12/24/20.
//  Copyright © 2020 MagyElias. All rights reserved.
//

import Foundation
import SpriteKit

class MamaEl3adraScene: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let touch = touches.first else {
            return
        }

        let location = touch.location(in: self)
        let node = self.atPoint(location)

        if (node.name == "mamaEl3adra") {
            // navigate to characters track screen
            guard let levelsScene = CharacterPartsScene(fileNamed: "CharacterPartsScene") else { return }
            let transition = SKTransition.doorway(withDuration: 1)
            self.view?.presentScene(levelsScene, transition: transition)
        }
    }
    
}
