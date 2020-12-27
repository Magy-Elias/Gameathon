//
//  PuzzleScene.swift
//  Gameathon
//
//  Created by Magy Elias on 12/26/20.
//  Copyright © 2020 MagyElias. All rights reserved.
//

import SpriteKit
import GameplayKit

class PuzzleScene: SKScene {
    
    // MARK: - Constants
    fileprivate struct Constants{
        static let succesSound = "success_sound"
        static let wrongSound = "wrong_sound"
        static let wonGameSound = "cheer"
        
        static let imageForPuzzle = "puzzel full photo-1"
        
        static let staticNodeName = "staticNodeName"
        static let movableNodeName = "movable"
        
        static let fontSize:CGFloat = 48
        
        static let puzzlePieceSnapDistance = CGFloat(50)
        
        static let puzzleImageSize = CGSize(width: 300, height: 260)
        static let numberOfPuzzlePieces = 4
        static let puzzlePieceSize = CGSize(width: CGFloat(puzzleImageSize.width / CGFloat(numberOfPuzzlePieces/2)),
                                            height: CGFloat(puzzleImageSize.height / CGFloat(numberOfPuzzlePieces/2)))
        
        static let labelOffset:CGFloat = 10
        
        static let animationDuration = 0.25
    }
    
    // MARK: - Variables
    private var selectedNode = SKSpriteNode()
    private var selectedNodeStartPosition = CGPoint()
    private var guidePhoto = SKSpriteNode()
    private var scoreLabel = SKLabelNode()
    var hintAudioNode = SKAudioNode()
    var isFirstTouch = 0
    
    let emitter = SKEmitterNode(fileNamed: "MyParticle")
    let colors = [SKColor.white, SKColor.yellow, SKColor.magenta ,SKColor.cyan, SKColor.blue]
    
    //Current puzzle pieces fitted
    private var score = 0{
        didSet{

            //Change the score label when score increases
            scoreLabel.text = setScoreString(score: score)
        }
        willSet{
            //Playes a sound when a player scores.
            if (newValue > score && newValue > 0) {
                SoundPlayer.playSound(soundName: Constants.succesSound)
                
            }
        }
    }
    
    func emitParticles() {
        
        emitter?.position = CGPoint(x: 0.5, y: 0.5)
        emitter?.particleColorSequence = nil
        emitter?.particleColorBlendFactor = 2.0
        
        self.addChild(emitter!)
        
        let action = SKAction.run({
            [unowned self] in
            let random = Int(arc4random_uniform(UInt32(self.colors.count)))
            
            self.emitter?.particleColor = self.colors[random];  //SKColor.yellow
        })
        
        let wait = SKAction.wait(forDuration: 0.1)
        
        self.run(SKAction.repeatForever( SKAction.sequence([action,wait])))
        
    }
    
    private func setScoreString(score: Int) -> String{
        return "Correct pieces: " + String(score) + "/\(Constants.numberOfPuzzlePieces)"
    }
    
    // MARK: - Model
    private var puzzle = Puzzle()
    
    //MARK: - GameState
    //Defining gamestates
    private enum GameState{
        case start
        case playing
        case won
    }
    
    private var gameState = GameState.start{
        //Handling gamestate change
        didSet{
            switch self.gameState {
                case .start:
                    setUpGuidePhoto()
                    //Create puzzle pieces from image
                    if let image = UIImage(named: Constants.imageForPuzzle){
                        puzzle.createPuzzlePieces(fromImage: image, forImageConversionSize: Constants.puzzleImageSize, forPuzzleSize: Constants.puzzlePieceSize)
                    }
                    
                    //Set the correct position for the puzzle pieces
                    puzzle.setCorrectPositions(inFrame: self.frame, forNumberOfPuzzlePieces: Constants.numberOfPuzzlePieces, ofPieceSize: Constants.puzzlePieceSize)
                    
                    //Positions the puzzle pieces in the current frame with random rotation values
                    puzzle.positionAndRotatePuzzlePieces(withName: Constants.movableNodeName, inFrame: self.frame)
                
                case .playing:
                    print("------ .playing")
                    setUpScoreLabel()

                    //Change the guide photo to be more transparent
                    guidePhoto.alpha = 0.3

//                    setUpRestartButton()

                    //Add puzzlePieces as children
                    addPuzzlePiecesAsChildren()
                
                case .won:
                    print("------ .won")
                    //Change font color
                    scoreLabel.fontColor = .green

                    self.emitParticles()
                    //Play the sound of the user scoring a point
//                    SoundPlayer.playSound(soundName: Constants.wonGameSound)
                    let cheerAudioNode = SKAudioNode(fileNamed:  Constants.wonGameSound)
                    cheerAudioNode.isPositional = false
                    self.addChild(cheerAudioNode)
                    cheerAudioNode.run(SKAction.play())
                    let sequence = SKAction.sequence([SKAction.wait(forDuration: 4.4)])
                    cheerAudioNode.run(sequence, completion: {
                        cheerAudioNode.removeFromParent()
                        guard let knestyScene = KnestyScene(fileNamed: "KnestyScene") else { return }
                        knestyScene.isFromBack = true
                        self.view?.presentScene(knestyScene, transition: SKTransition.moveIn(with: .left, duration: 0.5))
                        
                    })
            }
        }
    }
    
    func displayGameOver() {
        UserDefaults.standard.set(score, forKey: "score")
        
        let gameOverScene = GameOverScene(size: size)
        gameOverScene.scaleMode = scaleMode
        
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        view?.presentScene(gameOverScene, transition: reveal)
    }
    
    // MARK: - Setting up
    //Set up the guide photo
    private func setUpGuidePhoto(){
        guidePhoto = SKSpriteNode(imageNamed: Constants.imageForPuzzle)
        guidePhoto.size = Constants.puzzleImageSize
        guidePhoto.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        guidePhoto.name = Constants.staticNodeName
        guidePhoto.zPosition = 2
        
        self.addChild(guidePhoto)
    }
    
    //Set up the score label
    private func setUpScoreLabel(){
        scoreLabel.fontSize = Constants.fontSize
        scoreLabel.text = setScoreString(score: score)

        scoreLabel.fontColor = .white

        scoreLabel.position = CGPoint(x: self.frame.midX,
                                      y: self.frame.midY + Constants.puzzleImageSize.height/2 + Constants.labelOffset
        )
        scoreLabel.zPosition = 4


        //Add the label for displaying
//        self.addChild(scoreLabel)
    }
    
    //Set up the restart button
    private func setUpRestartButton(){
        
        let button = SKButton(imageNamed: "Group 5961")

        button.animatable = true

//        button.size = CGSize(width: 100, height: 50)
        button.anchorPoint = CGPoint(x: 0, y: 0)
        button.position = CGPoint(x: 250.0,
                                  y: -149.371)
        button.zPosition = 2
        
        //Excecute restartGame() then the user presses the button
        button.addTarget(target: self, selector: #selector(restartGame), event: SKButtonEvent.TouchUpInside)
        
        addChild(button)
    }
    
    //Add all puzzle pieces as children
    private func addPuzzlePiecesAsChildren(){
        for i in 0..<puzzle.puzzlePieces.0.count {
            self.addChild(puzzle.puzzlePieces.0[i])
        }
    }
    
    @objc private func restartGame(){
        
        //Reset the user score
        score = 0
        
        //Remove all elements
//        for i in 0 ..< self.children.count {
//            print(self.children[i].name)
//            if let childName = self.children[i].name, childName != "basicBg" && childName != "backBtn" {
//                self.removeFromParent()
//            }
//        }
        self.removeAllChildren()
        puzzle.puzzlePieces.0.removeAll()
        
        //Change the game state
        gameState = GameState.start
        
    }
    
    // MARK: - Move to view
    override func didMove(to view: SKView) {
        gameState = .start
        
        hintAudioNode = SKAudioNode(fileNamed: "puzzle")
        hintAudioNode.isPositional = false
        self.addChild(hintAudioNode)
        hintAudioNode.run(SKAction.play())
        
        let sequence = SKAction.sequence([SKAction.wait(forDuration: 7.73)])
        hintAudioNode.run(sequence, completion: {
            self.hintAudioNode.removeFromParent()
        })
    }
    
    // MARK: - Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Checks if game is in .start state
        if gameState == GameState.start {
            
            //Because the player initiated the game change the state to .playing
            gameState = GameState.playing
            
        } else {
            
            let touch = touches.first
            let positionInScene = touch?.location(in: self)
            
            selectNodeForTouch(touchLocation: positionInScene!)
            
//            //Rotate puzzle piece if the user does a double tap.
//            if touch?.tapCount == 2 && selectedNode.name != Constants.staticNodeName{
//
//                let rotateAction = SKAction.rotate(byAngle: CGFloat(Double.pi) / 2, duration: Constants.animationDuration)
//
//                //Run the rotation animation
//                selectedNode.run(rotateAction)
//            }
            
            //Remembers the starting position of a puzzle piece.
            selectedNodeStartPosition = selectedNode.position
        }
    }
    
    //Place puzzle piece if place is correct or reject it
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Check if node has name and movable
        if let name = selectedNode.name, name != Constants.staticNodeName {
            
            //Go through all the puzzle pieces to find the right one
            for i in 0 ..< Constants.numberOfPuzzlePieces {
                if selectedNode == puzzle.puzzlePieces.0[i] {
                    
//                    //Reset the unnecessary rotation amount
//                    if Int(selectedNode.zRotation) == 6 {
//                        selectedNode.zRotation = 0
//                    }
                    
                    let correctPosition = puzzle.puzzlePieces.1[i]
                    
                    //Check if user put the puzzle piece in the right place
                    if isPositionCorrect(forPuzzlePiece: selectedNode, correctPosition: correctPosition) {
                        
                        //Set up the selected node and put it in the right place.
                        selectedNode.position = correctPosition
                        selectedNode.name = Constants.staticNodeName
                        selectedNode.zPosition = 1
                        
                        //Increase the score
                        score += 1
                        
                        //Game ends if all pieces are in their right place
                        if score == Constants.numberOfPuzzlePieces {

                            //Change gamestate to .won
                            gameState = GameState.won
                        }
                    }
                    //Return puzzle piece to previous position if it was placed in the wrong place in the game field
                    else if isInGameField(puzzlePiece: selectedNode) {
                        
                        let moveAction = SKAction.move(to: selectedNodeStartPosition, duration: Constants.animationDuration)
                        
                        selectedNode.run(moveAction)
                        //Play the sound of the user making a mistake
                        SoundPlayer.playSound(soundName: Constants.wrongSound)
                    }
                }
            }
        }
    }
    
    //Return if puzzle piece is wrongly placed in game field
    private func isInGameField(puzzlePiece: SKSpriteNode) -> Bool {
        return selectedNode.position.y < (self.frame.midY + Constants.puzzleImageSize.height/2) &&
            selectedNode.position.y > (self.frame.midY - Constants.puzzleImageSize.height/2)
    }
    
    //Return if puzzle piece is correctly placed
    private func isPositionCorrect(forPuzzlePiece puzzlePiece: SKSpriteNode, correctPosition: CGPoint) -> Bool {
        
        return Swift.abs(selectedNode.position.x - correctPosition.x) < Constants.puzzlePieceSnapDistance
            && Swift.abs(selectedNode.position.y - correctPosition.y) < Constants.puzzlePieceSnapDistance
            && (Int(selectedNode.zRotation) == 0 || Int(selectedNode.zRotation) == 5)
    }
    
    //Drag puzzle piece to new position
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        let positionInScene = touch?.location(in: self)
        
        let previousPosition = touch?.previousLocation(in: self)
        let translation = CGPoint(x: (positionInScene?.x)! - (previousPosition?.x)!,
                                  y: (positionInScene?.y)! - (previousPosition?.y)!
        )
        //Change the selected nodes position when dragged
        panForTranslation(translation: translation)
        
    }
    
    //Changes the selected nodes position
    private func panForTranslation(translation: CGPoint) {
        let position = selectedNode.position
        
        if let name = selectedNode.name, name == Constants.movableNodeName {
            selectedNode.position = CGPoint(x: position.x + translation.x,
                                            y: position.y + translation.y
            )
            selectedNode.zPosition = 2
        }
    }
    
    //Select node based on touch
    private func selectNodeForTouch(touchLocation: CGPoint) {
        //Find node at touch location
        let touchedNode = self.atPoint(touchLocation)
        
        if touchedNode is SKSpriteNode {
             if (touchedNode.name == "mute") {
                
                if isFirstTouch % 2 == 0 {
                    hintAudioNode.run(SKAction.changeVolume(to: Float(0), duration: 0))
                    self.isFirstTouch += 1
                    (touchedNode as? SKSpriteNode)?.texture = SKTexture(imageNamed:"unmuteBlue")
                    
                } else {
                    hintAudioNode.run(SKAction.changeVolume(to: Float(1), duration: 0))
                    self.isFirstTouch += 1
                    (touchedNode as? SKSpriteNode)?.texture = SKTexture(imageNamed:"muteBlue")
                }
            }
            
            //Set touchedNode as solectedNode
            else if !selectedNode.isEqual(touchedNode) {
                selectedNode = touchedNode as! SKSpriteNode
            }
            
            else if (touchedNode.name == "backBtn") {
                guard let knestyScene = KnestyScene(fileNamed: "KnestyScene") else { return }
                knestyScene.isFromBack = true
                self.view?.presentScene(knestyScene, transition: SKTransition.moveIn(with: .left, duration: 0.5))
            }
        }
    }
}
