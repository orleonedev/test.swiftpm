//
//  File.swift
//  test
//
//  Created by Oreste Leone on 16/04/22.
//

import Foundation
import SwiftUI
import SpriteKit

struct MainScreenView: View {
    
    @Binding var currentGameState: GameState
    var gameTitle: String = "Title"
    var gumiScene: MenuScene {
        let scene = MenuScene()
        scene.size = CGSize(width: displayWidth, height: displayHeight)
        scene.scaleMode = .aspectFit
        
        return scene
    }
    
    var body: some View {
        Color.gray.edgesIgnoringSafeArea(.all)
        
        ZStack {
            SpriteView(scene: gumiScene )
        }
        
    }
    
    
    
}
