//
//  File.swift
//  test
//
//  Created by Oreste Leone on 16/04/22.
//

import Foundation
import SwiftUI
import SpriteKit

struct CookingView: View {
    
    @Binding var currentGameState: GameState
    @StateObject var gameLogic: GameLogic = GameLogic.shared
    var cookScene: CookingScene {
        let scene = CookingScene()
        scene.size = CGSize(width: displayWidth, height: displayHeight)
        scene.scaleMode = .aspectFit
        
        return scene
    }
    
    var body: some View {
        ZStack {
           SpriteView(scene: cookScene)
        }
    }
}

