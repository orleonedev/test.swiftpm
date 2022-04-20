//
//  File.swift
//  test
//
//  Created by Oreste Leone on 16/04/22.
//

import Foundation
import SpriteKit
import SwiftUI

class MenuScene: SKScene {
    
    var lastUpdate: TimeInterval = 0
    
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.init(red: 0, green: 0.01, blue: 0.1, alpha: 0.9)
        
        for i in 0...3 {
            let wait = SKAction.wait(forDuration: 1.0)
            let gumi: Gumi = Gumi()
            gumi.name = "gumi\(i)"
            gumi.position = CGPoint(x: (scene?.frame.midX ?? 0.0), y: (scene?.frame.midY ?? 0.0) + (GMUnit*1.4) - (GMUnit*CGFloat(i)))
           // gumi.position = CGPoint(x: view.center.x + GMUnit/2, y: view.center.y - GMUnit*1.8 + (GMUnit)*CGFloat(i))
            switch i {
            case 0:
                gumi.colorize( .green)
                gumi.run(SKAction.repeatForever(SKAction.sequence([gumi.moveLeft,wait,gumi.moveRight,wait])))
            case 1:
                gumi.colorize( .white)
                gumi.run(SKAction.repeatForever(SKAction.sequence([gumi.moveRight,wait,gumi.moveLeft,wait])))
            case 2:
                gumi.colorize( .red)
                gumi.run(SKAction.repeatForever(SKAction.sequence([gumi.moveLeft,wait,gumi.moveRight,wait])))
            default:
                gumi.colorize( .yellow)
                gumi.run(SKAction.repeatForever(SKAction.sequence([gumi.moveRight,wait,gumi.moveLeft,wait])))
            }
            self.addChild(gumi)
            
            
        }
         
        
        
    }
    
}
