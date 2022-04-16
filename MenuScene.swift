//
//  File.swift
//  test
//
//  Created by Oreste Leone on 16/04/22.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    
    var lastUpdate: TimeInterval = 0
    
    var gumi: SKSpriteNode? = SKSpriteNode(texture: SKTexture(imageNamed: "GumiDx"), color: .white, size: CGSize(width: measureUnit, height: measureUnit))
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.gray
        
        if let gumi = gumi {
            
            gumi.name = "gumi"
            gumi.physicsBody = SKPhysicsBody(circleOfRadius: measureUnit/2)
            gumi.physicsBody?.affectedByGravity = false
            gumi.position = view.center
            self.addChild(gumi)
            let act = SKAction.move(by: CGVector(dx: measureUnit, dy: 0.0), duration: 1.0)
            gumi.run(SKAction.repeatForever(SKAction.sequence([act,act.reversed()])))
        }
        
    }
    
}
