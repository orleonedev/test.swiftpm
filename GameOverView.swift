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
                .background(Circle().foregroundColor(Color(uiColor: UIColor.orange)).frame(width: 100, height: 100, alignment: .center))
                
                Spacer()
                
                Button {
                    withAnimation { self.restartGame() }
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.black)
                        .font(.title)
                }
                .background(Circle().foregroundColor(Color(uiColor: UIColor.orange)).frame(width: 100, height: 100, alignment: .center))
                
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

