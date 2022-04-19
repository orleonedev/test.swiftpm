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
    
    var body: some View {
        ZStack {
            Color.gray.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                Spacer()
                
                Button {
                    withAnimation { self.backToMainScreen() }
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
                        .font(.title)
                }
                .background(Circle().foregroundColor(sharedPalette.secondary).frame(width: GMUnit, height: GMUnit, alignment: .center))
                
                Spacer()
                
                Button {
                    withAnimation { self.restartGame() }
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.black)
                        .font(.title)
                }
                .background(Circle().foregroundColor(sharedPalette.secondary).frame(width: GMUnit, height: GMUnit, alignment: .center))
                
                Spacer()
            }
        }
        
    }
    
    private func backToMainScreen() {
        self.currentGameState = .mainScreen
    }
    
    private func restartGame() {
        self.currentGameState = .playing
    }
}

