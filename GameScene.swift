//
//  File.swift
//  test
//
//  Created by Oreste Leone on 16/04/22.
//

import Foundation
import SpriteKit
import SwiftUI

class GameScene: SKScene {
    
    var gumi: Gumi = Gumi()
    var gameLogic: GameLogic =  GameLogic.shared
    var lastUpdate: TimeInterval = 0
    var scoreLabel: SKLabelNode = SKLabelNode(text: String(format: "%.6d", 0))
    var timeLabel: SKLabelNode = SKLabelNode(text: String(format: "%.d", 45))
    var gumiPos: CGPoint {
        switch gameLogic.currentGumiPosition {
        case .left:
            return CGPoint(x: (scene?.frame.midX ?? 0.0) - GMUnit*1.4, y: (scene?.frame.minY ?? 0.0) + GMUnit)
        case .center:
            return CGPoint(x: (scene?.frame.midX ?? 0.0), y: (scene?.frame.minY ?? 0.0) + GMUnit)
        case .right:
            return CGPoint(x: (scene?.frame.midX ?? 0.0) + GMUnit*1.4, y: (scene?.frame.minY ?? 0.0) + GMUnit)
        }
    }
    
    override func didMove(to view: SKView) {
        self.setUpGame()
        self.setUpPhysicsWorld()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        // ...
        
        // If the game over condition is met, the game will finish
        if self.isGameOver { self.finishGame() }
        
        // The first time the update function is called we must initialize the
        // lastUpdate variable
        if self.lastUpdate == 0 { self.lastUpdate = currentTime }
        
        // Calculates how much time has passed since the last update
        let timeElapsedSinceLastUpdate = currentTime - self.lastUpdate
        // Increments the length of the game session at the game logic
        self.gameLogic.decreaseSessionTime(by: timeElapsedSinceLastUpdate)
        scoreLabel.text = String(format: "%.6d", gameLogic.currentScore)
        timeLabel.text = String(format: "%.d", Int(gameLogic.sessionDuration))
        gumi.position = gumiPos
        self.lastUpdate = currentTime
    }
    
}

// MARK: - Game Scene Set Up
extension GameScene {
    
    private func setUpGame() {
        self.gameLogic.setUpGame()
        self.backgroundColor = SKColor.init(red: 0, green: 0.01, blue: 0.1, alpha: 0.9)
        print("SCENE Love: \(gameLogic.wants)")
        print("SCENE Hates: \(gameLogic.hates)")
        
        scoreLabel.text = String(format: "%.6d", gameLogic.currentScore)
        scoreLabel.fontColor = .white
        scoreLabel.fontName = "VT323-Regular"
        scoreLabel.fontSize = GMUnit/2
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.verticalAlignmentMode = .top
        scoreLabel.position = CGPoint(x: (scene?.frame.maxX ?? 0.0) - GMUnit/8, y: (scene?.frame.maxY ?? 0.0) - GMUnit/8)
        self.addChild(scoreLabel)
        
        timeLabel.text = String(format: "%.d", Int(gameLogic.sessionDuration))
        timeLabel.fontName = "VT323-Regular"
        timeLabel.fontSize = GMUnit/2
        timeLabel.horizontalAlignmentMode = .left
        timeLabel.verticalAlignmentMode = .top
        timeLabel.position = CGPoint(x: (scene?.frame.minX ?? 0.0) + GMUnit/8, y: (scene?.frame.maxY ?? 0.0) - GMUnit/8)
        self.addChild(timeLabel)
        
        gumi.colorize(gameLogic.gumiColor)
        gumi.position = gumiPos
        gumi.name = "gumi"
        self.addChild(gumi)
        
        
    }
    
    private func setUpPhysicsWorld() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.9)
        
    }
    
    private func restartGame() {
        self.gameLogic.restartGame()
    }
    
    private func newIngredient(at position: CGPoint) {
        let newIngredient = SKShapeNode(circleOfRadius: 25)
        newIngredient.name = "asteroid"
        newIngredient.fillColor = SKColor.red
        newIngredient.strokeColor = SKColor.black
        newIngredient.position = position
        addChild(newIngredient)
    }
    
    private func randomIngredientPosition() -> CGPoint {
        let initialX: CGFloat = 25
        let finalX: CGFloat = self.frame.width - 25

        let positionX = CGFloat.random(in: initialX...finalX)
        let positionY = frame.height - GMUnit
        
        return CGPoint(x: positionX, y: positionY)
    }
}


// MARK: - Handle Player Inputs
extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // TODO: Customize!
        
        //self.gameLogic.finishTheGame()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: Customize!
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: Customize!
    }
    
}


// MARK: - Game Over Condition
extension GameScene {
    
    /**
     * Implement the Game Over condition.
     * Remember that an arcade game always ends! How will the player eventually lose?
     *
     * Some examples of game over conditions are:
     * - The time is over!
     * - The player health is depleated!
     * - The enemies have completed their goal!
     * - The screen is full!
     **/
    
    var isGameOver: Bool {
        var returnable = false
        if gameLogic.sessionDuration < 0 {
            returnable = true
        }
        return returnable
    }
    
    private func finishGame() {
        
        // TODO: Customize!
        
        gameLogic.isGameOver = true
    }
    
}

// MARK: - Register Score
extension GameScene {
    
    private func registerScore() {
        // TODO: Customize!
    }
    
}

