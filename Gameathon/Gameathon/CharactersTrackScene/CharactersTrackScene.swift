//
//  CharactersTrackScene.swift
//  Gameathon
//
//  Created by Samar Younan on 12/24/20.
//  Copyright © 2020 MagyElias. All rights reserved.
//

import Foundation
import SpriteKit

class CharactersTrackScene: SKScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        let node = self.atPoint(location)
        
        if (node.name == "mamaEl3adra") {
            
            // navigate to characters track screen
            guard let mamaEl3adraScene = MamaEl3adraScene(fileNamed: "MamaEl3adraScene") else { return }
            self.view?.presentScene(mamaEl3adraScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
            
        } else if (node.name == "backBtn") {
            guard let selectionScene = SelectionScene(fileNamed: "SelectionScene") else { return }
            self.view?.presentScene(selectionScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
        }
    }
}
