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
    
    var gumi: Gumi? = Gumi()
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.init(red: 0, green: 0.01, blue: 0.1, alpha: 0.9)
        
        if let gumi = gumi {
            
            gumi.name = "gumi"
            gumi.position = CGPoint(x: view.center.x + GMUnit/2, y: view.center.y)
            self.addChild(gumi)
            let wait = SKAction.wait(forDuration: 1.0)
            gumi.run(SKAction.repeatForever(SKAction.sequence([gumi.moveLeft,wait,gumi.moveRight,wait])))
        }
        
    }
    
}
