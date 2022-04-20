//
//  File.swift
//  test
//
//  Created by Oreste Leone on 17/04/22.
//

import Foundation
import SpriteKit

class Gumi: SKSpriteNode {
    
    var leftSprite: SKTexture = SKTexture(imageNamed: "GumiSx")
    var rightSprite: SKTexture = SKTexture(imageNamed: "GumiDx")
    var rightAtlas: [SKTexture]
    var leftAtlas: [SKTexture]
    
    var rightAnim: SKAction {
        return SKAction.repeatForever(SKAction.animate(with: rightAtlas, timePerFrame: 0.2))
    }
    
    var leftAnim: SKAction {
        return SKAction.repeatForever(SKAction.animate(with: leftAtlas, timePerFrame: 0.2))
    }
    
    var isMovingLeft: Bool = false {
        didSet{
            if isMovingLeft {
                self.run(leftAnim)
            }
            else{
                self.run(rightAnim)
            }
        }
    }
    
    var moveLeft: SKAction {
        
        return SKAction.run {
            self.isMovingLeft = true
            self.run(SKAction.move(by: CGVector(dx: -GMUnit, dy: 0.0), duration: 1.0))
            
        }
    }
    var moveRight: SKAction {
        
        return SKAction.run {
            self.isMovingLeft = false
            self.run(SKAction.move(by: CGVector(dx: GMUnit, dy: 0.0), duration: 1.0))
            
        }
    }
    
    
    init() {
        rightAtlas = [rightSprite]
        leftAtlas = [leftSprite]
        super.init(texture: rightSprite, color: .white, size: CGSize(width: GMUnit, height: GMUnit))
        self.physicsBody = SKPhysicsBody(circleOfRadius: GMUnit/2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func colorize(_ color: UIColor){
        self.color = color
        self.colorBlendFactor = 0.5
    }
    
    
    
    
    
}
