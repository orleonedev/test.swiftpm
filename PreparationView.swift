//
//  File.swift
//  test
//
//  Created by Oreste Leone on 19/04/22.
//

import Foundation
import SwiftUI
import SpriteKit

struct PreparationView: View {
    
    @Binding var currentGameState: GameState
    @StateObject var gameLogic: GameLogic =  GameLogic.shared
    
    
    var prepScene: WhatToEatScene {
        let scene = WhatToEatScene()
        scene.size = CGSize(width: displayWidth, height: displayHeight)
        scene.scaleMode = .aspectFit
        
        return scene
    }
    
    
    var body: some View{
        ZStack(alignment: .top) {
            // View that presents the game scene
            SpriteView(scene: prepScene)
            
        }.onAppear{
            gameLogic.initializeGame()
        }
    }
    
}
