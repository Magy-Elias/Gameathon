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
    private var mainCharacter: SKSpriteNode?
    private var submitButton: SKSpriteNode?
    private var isSubmitting: Bool = true
    
    var scoreLabel = SKLabelNode()
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        // Character
//        mainCharacter = SKSpriteNode(imageNamed: "elbsharaIcon")
//        mainCharacter?.position = CGPoint(x: 16.053, y: 3.491)
//        mainCharacter?.size = CGSize(width: 161.16, height: 240.889)
//        mainCharacter?.name = "mainCharacter"
//        mainCharacter?.zPosition = -1
//        addChild(mainCharacter!)
        
        mainCharacter = childNode(withName: "mainCharacter") as? SKSpriteNode
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: mainCharacter!.frame)
        self.physicsWorld.contactDelegate = self
        
        // Submit Button
//        submitButton = SKSpriteNode(imageNamed: "Group 2146")
//        submitButton?.position = CGPoint(x: 134.293, y: 70.0)
//        submitButton?.size = CGSize(width: 60.0, height: 60.0)
//        submitButton?.name = "submitButton"
//        addChild(submitButton!)
        submitButton = childNode(withName: "submitButton") as? SKSpriteNode
        
        // score label
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        score = UserDefaults.standard.integer(forKey: "score")
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontColor = .red
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: self.frame.midX + 110, y: 150)
//        addChild(scoreLabel)
    }
    
    /// will be called when a player first touches the screen
    /// - Parameters:
    ///   - touches: contains information about each touch event that occurred
    ///   - event: gives information about the type of interaction
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Initialize drag here.
        if let touch = touches.first, isSubmitting {
            let location = touch.location(in: self)
            
            let node = self.atPoint(location)
            
            if (node.name == "backBtn") {
                guard let levelsScene = LevelsScene(fileNamed: "LevelsScene") else { return }
                self.view?.presentScene(levelsScene, transition: SKTransition.moveIn(with: .left, duration: 0.5))
            }
            
            
            // you call the nodes(at:) method to get an array of all nodes at the touch location
            let touchedNodes = self.nodes(at: location)
            // The nodes are looked at in reverse order as a primitive way to select nodes that appear on top “first”
            for node in touchedNodes.reversed() {
                if (node.name == "character1") || (node.name == "character2") || (node.name == "character3")  {
                    self.currentNode = node
                }
            }
            
        }
    }
    
    /// is called each time iOS wants to notify you of a new movement event
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode{
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
        }
    }
    
    /// This ensures that when the user lifts their finger, the drag action completes
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let node = self.currentNode, let mainCharacter = mainCharacter {
            if node.frame.intersects(mainCharacter.frame) {
                print("---- node on mainCharacter")
                
                node.setScale(0.2)
//                self.physicsWorld.body(in: mainCharacter.frame)
            }
        }
        
        if let touch = touches.first, let mainCharacter = mainCharacter {
            let location = touch.location(in: self)
            
            let node = self.atPoint(location)
        
            if node.name == "submitButton" {
                if mainCharacter.intersects(childNode(withName: "character1")!) {
                    score += 1
                }
                if mainCharacter.intersects(childNode(withName: "character3")!) {
                    score += 1
                }
                if mainCharacter.intersects(childNode(withName: "character2")!) {
                    score -= 1
                }
                
                self.isSubmitting = false
                if mainCharacter.intersects(childNode(withName: "character2")!) {
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
                    let cheerAudioNode = SKAudioNode(fileNamed: "cheer.mp3")
                    cheerAudioNode.isPositional = false
                    self.addChild(cheerAudioNode)
                    cheerAudioNode.run(SKAction.play())
                    let sequence = SKAction.sequence([SKAction.wait(forDuration: 4.5)])
                    cheerAudioNode.run(sequence, completion: {
                        cheerAudioNode.removeFromParent()
                        self.displayGameOver()
                    })
                }
            }
        }
        
        self.currentNode = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    
    func displayGameOver() {
        UserDefaults.standard.set(score, forKey: "score")
        
        let gameOverScene = GameOverScene(size: size)
        gameOverScene.scaleMode = scaleMode
        
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        view?.presentScene(gameOverScene, transition: reveal)
    }
}
