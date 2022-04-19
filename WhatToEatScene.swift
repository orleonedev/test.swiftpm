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
    
    var lastUpdate: TimeInterval = 0
    var meals: [String] = ["🍎","🍐","🍊","🍋","🍌"]
    var gumi: Gumi? = Gumi()
    var wants: [String] = []
    var hates: [String] = []
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.init(red: 0, green: 0.01, blue: 0.1, alpha: 0.9)
        
        if let gumi = gumi {
            
            gumi.name = "gumi"
            gumi.physicsBody = SKPhysicsBody(circleOfRadius: GMUnit/2)
            gumi.physicsBody?.affectedByGravity = false
            gumi.position = view.center
            self.addChild(gumi)
            
        }
        
        for _ in 0...2 {
            let index = Int.random(in: 0...2)
            wants.append(meals.remove(at: index))
        }
        hates.append(contentsOf: meals)
        
        
        for i in 0..<wants.count {
            let fruit = SKLabelNode(text: wants[i])
            fruit.fontSize = GMUnit/1.5
            fruit.position = CGPoint(x: (gumi?.position.x ?? view.center.x) - GMUnit + GMUnit*CGFloat(i), y: (gumi?.position.y ?? view.center.y) + GMUnit*2.0)
            fruit.name = "FruitWanted\(i)"
            //fruit.zPosition = 1
            self.addChild(fruit)
        }
        
        for i in 0..<hates.count {
            let fruit = SKLabelNode(text: hates[i])
            fruit.fontSize = GMUnit/1.5
            fruit.position = CGPoint(x: (gumi?.position.x ?? view.center.x) - GMUnit + GMUnit*CGFloat(i), y: (gumi?.position.y ?? view.center.y) - GMUnit*2.0)
            fruit.name = "FruitHate\(i)"
            //fruit.zPosition = 1
            self.addChild(fruit)
        }
        
    }
}
