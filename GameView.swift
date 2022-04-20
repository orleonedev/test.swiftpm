//
//  File.swift
//  test
//
//  Created by Oreste Leone on 16/04/22.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    
    @Binding var currentGameState: GameState
    @StateObject var gameLogic: GameLogic =  GameLogic.shared
    
    
    var gameScene: GameScene {
        let scene = GameScene()
        scene.size = CGSize(width: displayWidth, height: displayHeight)
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    var body: some View{
        ZStack(alignment: .top) {
            // View that presents the game scene
            SpriteView(scene: self.gameScene)
            
            
        }.onChange(of: gameLogic.isGameOver) { _ in
            if gameLogic.isGameOver {
                
                /** # PRO TIP!
                 * You can experiment by adding other types of animations here before presenting the game over screen.
                 */
                
                withAnimation {
                    self.presentGameOverScreen()
                }
            }
        }
        .onAppear {
            gameLogic.restartGame()
        }
    }
    private func presentMainScreen() {
        self.currentGameState = .mainScreen
    }
    private func presentGameOverScreen() {
        self.currentGameState = .gameOver
    }
}
