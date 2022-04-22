//
//  CookingScene.swift
//  GumiEats
//
//  Created by Oreste Leone on 22/04/22.
//

import Foundation
import SpriteKit
import SwiftUI

class CookingScene: SKScene {
    
    var gameLogic: GameLogic = GameLogic.shared
    var lastUpdate: TimeInterval = 0
    var pizza: SKSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "Pizza"), color: .white, size: CGSize(width: GMUnit*3, height: GMUnit*3))
    let flame = SKSpriteNode(texture: SKTexture(imageNamed: "Fire"), color: UIColor.red, size: CGSize(width: GMUnit*2, height: GMUnit*2))
    var finalScore = SKLabelNode(text: String(format: "%.6d", 0))
    let instructions = SKLabelNode(text: "Press Star on the right time!")
    var distance: Double {
        return (pizza.position.y)-(flame.position.y)
    }
    
    var updateEnabled: Bool = true
    var stopCook: Bool = false {
        willSet{
            if newValue {
                gameLogic.finalScore = gameLogic.calculateFinalScore(distance: distance)
                print(gameLogic.finalScore)
                finalScore.text = String(format: "%.d", gameLogic.finalScore)
                itsEatTime()
                
            }
        }
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.init(red: 0, green: 0.01, blue: 0.1, alpha: 0.9)
        
        pizza.name = "pizza"
        pizza.colorBlendFactor = 1.0
        pizza.position = view.center
        self.addChild(pizza)
        
        finalScore.name = "finalScore"
        finalScore.fontName = "VT323-Regular"
        finalScore.fontSize = GMUnit/2
        finalScore.horizontalAlignmentMode = .center
        finalScore.verticalAlignmentMode = .top
        finalScore.position = CGPoint(x: (scene?.frame.midX ?? 0.0) , y: (scene?.frame.maxY ?? 0.0) - GMUnit/8)
        finalScore.isHidden = true
        self.addChild(finalScore)
        
        instructions.name = "instructions"
        instructions.fontName = "VT323-Regular"
        instructions.fontSize = GMUnit/2
        instructions.horizontalAlignmentMode = .center
        instructions.verticalAlignmentMode = .top
        instructions.position = CGPoint(x: (scene?.frame.midX ?? 0.0) , y: (scene?.frame.maxY ?? 0.0) - GMUnit/8)
        self.addChild(instructions)
        
        
        flame.name = "flame"
        flame.position = CGPoint(x: (scene?.frame.midX ?? 0.0) , y: (scene?.frame.minY ?? 0.0) + GMUnit/8)
        flame.run(SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed: "Fire"),SKTexture(imageNamed: "Fire2")], timePerFrame: 0.2)))
        self.addChild(flame)
        flame.run(SKAction.moveTo(y: (scene?.frame.maxY ?? 0.0) - GMUnit/8, duration: 5.0))
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
        if self.lastUpdate == 0 { self.lastUpdate = currentTime }
        let timeElapsedSinceLastUpdate = currentTime - self.lastUpdate
        
        switch distance {
        case 2*GMUnit..<3*GMUnit:
            pizza.colorBlendFactor = 0.9
        case GMUnit..<2*GMUnit:
            pizza.colorBlendFactor = 0.5
        case GMUnit/2..<GMUnit:
            pizza.colorBlendFactor = 0.2
        case -GMUnit/2 ..< GMUnit/2 :
            pizza.colorBlendFactor = 0.0
        case -GMUnit..<(-GMUnit/2):
            pizza.color = .black
            pizza.colorBlendFactor = 0.2
        case -GMUnit*2 ..< -GMUnit :
            pizza.colorBlendFactor = 0.2
        case -GMUnit*3 ..< -GMUnit*2 :
            pizza.colorBlendFactor = 0.9
        default:
            pizza.colorBlendFactor = 1.0
        }
        if updateEnabled{
            if gameLogic.stopCooking {
                updateEnabled = false
                stopCook = true
                
            }
        }
        
        self.lastUpdate = currentTime
    }
    
    func itsEatTime(){
        instructions.removeFromParent()
        flame.removeFromParent()
        
        finalScore.isHidden = false
        
    }
    
}
