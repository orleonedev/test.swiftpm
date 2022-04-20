//
//  File.swift
//  test
//
//  Created by Oreste Leone on 19/04/22.
//

import Foundation
import SpriteKit
import SwiftUI

class WhatToEatScene: SKScene {
    
    var gameLogic: GameLogic = GameLogic.shared
    var lastUpdate: TimeInterval = 0
    var gumi: Gumi? = Gumi()
    
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.init(red: 0, green: 0.01, blue: 0.1, alpha: 0.9)
        
        if let gumi = gumi {
            gumi.colorize(gameLogic.gumiColor)
            gumi.name = "gumi"
            gumi.position = view.center
            self.addChild(gumi)
            
        }
        
        for i in 0..<gameLogic.wants.count {
            let fruit = SKLabelNode(text: gameLogic.wants[i])
            fruit.fontSize = GMUnit/2
            fruit.position = CGPoint(x: (gumi?.position.x ?? view.center.x) - GMUnit + GMUnit*CGFloat(i), y: (gumi?.position.y ?? view.center.y) + GMUnit*1.5)
            fruit.name = "FruitWanted\(i)"
            fruit.zPosition = 1
            self.addChild(fruit)
        }
        
        for i in 0..<gameLogic.hates.count {
            let fruit = SKLabelNode(text: gameLogic.hates[i])
            fruit.fontSize = GMUnit/2
            fruit.position = CGPoint(x: (gumi?.position.x ?? view.center.x) - GMUnit + GMUnit*CGFloat(i), y: (gumi?.position.y ?? view.center.y) - GMUnit*1.5)
            fruit.name = "FruitHate\(i)"
            fruit.zPosition = 1
            self.addChild(fruit)
        }
        
        print("PREP Love: \(gameLogic.wants)")
        print("PREP Hates: \(gameLogic.hates)")
    }
    
    
}
