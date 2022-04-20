//
//  File.swift
//  test
//
//  Created by Oreste Leone on 16/04/22.
//

import Foundation
import SwiftUI

struct GameOverView: View {
    
    @Binding var currentGameState: GameState
    var sharedPalette: ColorPalette = ColorPalette.sharedPalette
    var gameLogic: GameLogic = GameLogic.shared
    
    var body: some View {
        ZStack {
            Color.init(red: 0.0, green: 0.01, blue: 0.1, opacity: 0.9).edgesIgnoringSafeArea(.all)
            Text("Pizza Rating: \(gameLogic.currentScore)")
                .foregroundColor(.white)
                .fontWeight(.heavy)
            
            
        }
        
    }
    
}

