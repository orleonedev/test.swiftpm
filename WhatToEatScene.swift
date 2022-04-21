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
        
        let wantLabel = SKLabelNode(text: "Love:")
        wantLabel.fontColor = .white
        wantLabel.fontName = "VT323-Regular"
        wantLabel.fontSize = GMUnit/2
        wantLabel.position = CGPoint(x: gumi?.position.x ?? view.center.x, y: (gumi?.position.y ?? view.center.y) + GMUnit*1.5)
        self.addChild(wantLabel)
        
        for i in 0..<gameLogic.wants.count {
            
            let ingredient: String = gameLogic.wants[i]
            
            let sprite = SKSpriteNode(texture: SKTexture(imageNamed: ingredient), color: UIColor.green, size: CGSize(width: GMUnit/2, height: GMUnit/2))
            sprite.position = CGPoint(x: (gumi?.position.x ?? view.center.x) - GMUnit + GMUnit*CGFloat(i), y: (gumi?.position.y ?? view.center.y) + GMUnit)
            sprite.name = ingredient
            sprite.zPosition = 1
            self.addChild(sprite)
            
        }
        
        let hateLabel = SKLabelNode(text: "Dislike:")
        hateLabel.fontColor = .white
        hateLabel.fontName = "VT323-Regular"
        hateLabel.fontSize = GMUnit/2
        hateLabel.position = CGPoint(x: gumi?.position.x ?? view.center.x, y: (gumi?.position.y ?? view.center.y) - GMUnit)
        self.addChild(hateLabel)
        
        for i in 0..<gameLogic.hates.count {
            
            let ingredient: String = gameLogic.hates[i]
            
            let sprite = SKSpriteNode(texture: SKTexture(imageNamed: ingredient), color: UIColor.red, size: CGSize(width: GMUnit/2, height: GMUnit/2))
            sprite.position = CGPoint(x: (gumi?.position.x ?? view.center.x) - (GMUnit/2) + GMUnit*CGFloat(i), y: (gumi?.position.y ?? view.center.y) - GMUnit*1.5)
            sprite.name = ingredient
            sprite.zPosition = 1
            self.addChild(sprite)
            
        }
    }
}
