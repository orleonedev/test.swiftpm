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
    var gumiScene: MenuScene {
        let scene = MenuScene()
        scene.size = CGSize(width: displayWidth, height: displayHeight)
        scene.scaleMode = .aspectFit
        
        return scene
    }
    
    @State var op: Double = 1.0
    
    var body: some View {
        
        ZStack {
            
            SpriteView(scene: gumiScene )
            VStack(alignment: .center, spacing: GMUnit/5){
                
                Text("GumiEats!")
                    .font(.custom("boh", size: GMUnit/1.5))
                    .fontWeight(.black)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("Press \(Image(systemName: "star.fill")) to start")
                    .font(.custom("Subhead", size: GMUnit/3))
                    .foregroundColor(.white)
                    .opacity(op)
                    .onAppear{
                        let baseAnim = Animation.easeInOut(duration: 1.0)
                        let redo = baseAnim.repeatForever(autoreverses: true)
                        withAnimation(redo){
                            op = 0.0
                        }
                    }
                
                Text("Press \(Image(systemName: "arrowtriangle.left.fill")) or \(Image(systemName: "arrowtriangle.right.fill")) to change GumiCom colors!")
                    .font(.custom("Subhead", size: GMUnit/5))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .opacity(op)
                    .onAppear{
                        let baseAnim = Animation.easeIn(duration: 1.0)
                        let redo = baseAnim.repeatForever(autoreverses: true)
                        withAnimation(redo){
                            op = 0.0
                        }
                    }
                    
                    
            }
            .padding()
            
            
        }
        
    }
    
    
    
}
