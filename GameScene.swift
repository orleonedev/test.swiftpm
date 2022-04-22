//
//  File.swift
//  test
//
//  Created by Oreste Leone on 16/04/22.
//

import Foundation
import SpriteKit
import SwiftUI

struct PhysicsCategory {
    static let none     : UInt32 = 0
    static let all      : UInt32 = UInt32.max
    static let player   : UInt32 = 0b1
    static let ingredients : UInt32 = 0b10
}

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
    
    var timeSpan: TimeInterval = 2.0
    var waiting: TimeInterval = 2.0
    
    override func didMove(to view: SKView) {
        self.setUpGame()
        self.setUpPhysicsWorld()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
        
        // If the game over condition is met, the game will finish
        if self.isGameOver { self.finishCatching() }
        
        // The first time the update function is called we must initialize the
        // lastUpdate variable
        if self.lastUpdate == 0 { self.lastUpdate = currentTime }
        
        // Calculates how much time has passed since the last update
        let timeElapsedSinceLastUpdate = currentTime - self.lastUpdate
        // Increments the length of the game session at the game logic
        self.gameLogic.decreaseSessionTime(by: timeElapsedSinceLastUpdate)
        waiting -= timeElapsedSinceLastUpdate
        if waiting < 0 {
            createIngredient()
            //print(numberof) // sono circa 50 buoni , una media tra 50 e 15 (32,5)*50 = 1625
            if timeSpan > 0.5 {
                timeSpan -= 0.1
            }
            waiting = timeSpan
        }
        
        scoreLabel.text = String(format: "%.6d", gameLogic.currentScore)
        timeLabel.text = String(format: "%.d", Int(gameLogic.sessionDuration))
        gumi.position = gumiPos
        self.lastUpdate = currentTime
    }
    
}

// MARK: - Game Scene Set Up
extension GameScene {
    
    private func setUpGame() {
        //self.gameLogic.setUpGame()
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
        physicsWorld.contactDelegate = self
    }
    
    private func restartGame() {
        self.gameLogic.restartGame()
    }
    
    private func newIngredient(at position: CGPoint) {
        let ingredientName = gameLogic.ingredients.randomElement()
        
        let newIngredient = SKSpriteNode(texture: SKTexture(imageNamed: ingredientName ?? "Cheese"), color: UIColor.green, size: CGSize(width: GMUnit/1.5, height: GMUnit/1.5))
        newIngredient.name = ingredientName
        newIngredient.position = position
        newIngredient.physicsBody = SKPhysicsBody(circleOfRadius: GMUnit/3)
        newIngredient.physicsBody?.categoryBitMask = PhysicsCategory.ingredients
        newIngredient.physicsBody?.contactTestBitMask = PhysicsCategory.player
        newIngredient.physicsBody?.collisionBitMask = PhysicsCategory.player
        addChild(newIngredient)
        
        
    }
    
    private func randomIngredientPosition() -> CGPoint {
        var positionX: CGFloat
        let positionY: CGFloat = (scene?.frame.maxY ?? 0.0) - GMUnit
        
        switch Int.random(in: 0...2){
        case 1:
            positionX = (scene?.frame.midX ?? 0.0)
        case 2:
            positionX = (scene?.frame.midX ?? 0.0) + GMUnit*1.4
        default:
            positionX = (scene?.frame.midX ?? 0.0) - GMUnit*1.4
        }
        
        
        return CGPoint(x: positionX, y: positionY)
    }
    
    private func createIngredient() {
        let ingredientPosition = self.randomIngredientPosition()
        newIngredient(at: ingredientPosition)
    }
    
}

// MARK: - Game Over Condition
extension GameScene {
    
    var isGameOver: Bool {
        var returnable = false
        if gameLogic.sessionDuration < 0 {
            returnable = true
        }
        return returnable
    }
    
    private func finishCatching() {
        
        gameLogic.ingredientCatchOver = true
    }
    
}

// MARK: - Register Score
extension GameScene {
    
    private func registerScore() {
        // TODO: Customize!
    }
    
}

extension GameScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
        
        let firstBody: SKPhysicsBody = contact.bodyA
        let secondBody: SKPhysicsBody = contact.bodyB
        
        if let node = firstBody.node ,node.name != "gumi" {
            
            if gameLogic.wants.contains(node.name ?? ""){
                
                gameLogic.score(points: 50)
            }
            else if gameLogic.hates.contains(node.name ?? ""){
                
                gameLogic.score(points: -75)
            }else{
                
                gameLogic.score(points: 15)
            }
            
            node.removeFromParent()
        }
        
        if let node = secondBody.node, node.name != "gumi" {
            if gameLogic.wants.contains(node.name ?? ""){
                
                gameLogic.score(points: 50)
            }
            else if gameLogic.hates.contains(node.name ?? ""){
                
                gameLogic.score(points: -75)
            }else{
                
                gameLogic.score(points: 15)
            }
            
            node.removeFromParent()
        }
    }
    
}

