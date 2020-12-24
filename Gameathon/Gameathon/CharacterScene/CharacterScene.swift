//
//  CharacterScene.swift
//  Gameathon
//
//  Created by Samar Younan on 12/19/20.
//  Copyright © 2020 Samar Younan. All rights reserved.
//

import Foundation
import SpriteKit


class CharacterScene: SKScene, SKPhysicsContactDelegate {
    
    // add a field to store the current moving node
    private var currentNode: SKNode?
    private var human: SKSpriteNode?
    
    var scoreLabel = SKLabelNode()
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsWorld.contactDelegate = self

        // Character
        human = SKSpriteNode(imageNamed: "unknown")
        human?.position = CGPoint(x: 264.293, y: -19.334)
        human?.size = CGSize(width: 161.16, height: 240.889)
        human?.name = "human"
        addChild(human!)
        
        // score label
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        score = UserDefaults.standard.integer(forKey: "score")
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontColor = .red
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: self.frame.midX + 110, y: 150)
        addChild(scoreLabel)
    }
    
    /// will be called when a player first touches the screen
    /// - Parameters:
    ///   - touches: contains information about each touch event that occurred
    ///   - event: gives information about the type of interaction
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Initialize drag here.
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let node = self.atPoint(location)
            
            if (node.name == "backBtn") {
                guard let mainScene = MainScene(fileNamed: "MainScene") else { return }
                self.view?.presentScene(mainScene, transition: SKTransition.moveIn(with: .right, duration: 0.5))
            }
            
            // you call the nodes(at:) method to get an array of all nodes at the touch location
            let touchedNodes = self.nodes(at: location)
            // The nodes are looked at in reverse order as a primitive way to select nodes that appear on top “first”
            for node in touchedNodes.reversed() {
                if (node.name == "nbla") || (node.name == "qethara") || (node.name == "shabka") ||
                   (node.name == "sheep")  {
                    self.currentNode = node
                }
            }
        }
    }
    
    /// is called each time iOS wants to notify you of a new movement event
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
        }
    }
    
    /// This ensures that when the user lifts their finger, the drag action completes
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let node = self.currentNode, let human = human {
            if node.frame.intersects(human.frame) {
                print("---- node on human")
                if let nodeName = node.name, nodeName == "shabka" {
                    print("wrong answer")
                    let wrongAnswerAudioNode = SKAudioNode(fileNamed: "wrongAnswer.mp3")
                    wrongAnswerAudioNode.isPositional = false
                    self.addChild(wrongAnswerAudioNode)
                    wrongAnswerAudioNode.run(SKAction.play())
                    let sequence = SKAction.sequence([SKAction.wait(forDuration: 2)])
                    wrongAnswerAudioNode.run(sequence, completion: {
                        wrongAnswerAudioNode.removeFromParent()
                        self.displayGameOver()
                    })
                } else {
                    print("Bravooooo")
                }
            }
        }
        self.currentNode = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    
    func displayGameOver() {
        
        let gameOverScene = GameOverScene(size: size)
        gameOverScene.scaleMode = scaleMode
        
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        view?.presentScene(gameOverScene, transition: reveal)
    }
}
