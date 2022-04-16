import SwiftUI


struct ContentView: View {
    
    @State var currentGameState: GameState = .mainScreen
    @StateObject var gameLogic: GameLogic = GameLogic()
    @StateObject var colorPalette: ColorPalette = ColorPalette()
    
    
    var body: some View {
        
        VStack(alignment: .center, spacing: measureUnit/2){
           
           ZStack{
               switch currentGameState {
               case .mainScreen:
                   MainScreenView(currentGameState: $currentGameState)
               
               case .playing:
                   GameView(currentGameState: $currentGameState)
                       .environmentObject(gameLogic)
               
               case .gameOver:
                   GameOverView(currentGameState: $currentGameState)
                       .environmentObject(gameLogic)
               }
            
           }
           .frame(width: displayWidth, height: displayHeight, alignment: .center)
           
            HStack(alignment: .center, spacing: measureUnit) {
               
                Button {
                    if currentGameState == .mainScreen {
                        withAnimation { self.colorPalette.changeHue() }
                    }
                } label: {
                Image(systemName: "arrowtriangle.left.fill")
                    .resizable()
                    .frame(width: measureUnit/2, height: measureUnit/2, alignment: .center)
                    
            }
            .foregroundColor(.white.opacity(0.5))
            .background(Circle().foregroundColor(colorPalette.secondary).frame(width: measureUnit, height: measureUnit, alignment: .center))
                
               Button {
               if currentGameState == .mainScreen {
                   withAnimation { self.startGame() }
               }
               
           } label: {
               Image(systemName: "star.fill")
                   .resizable()
                   .frame(width: measureUnit/2, height: measureUnit/2, alignment: .center)
                   
           }
           .foregroundColor(.white.opacity(0.5))
           .background(Circle().foregroundColor(colorPalette.secondary).frame(width: measureUnit, height: measureUnit, alignment: .center))
                
                Button {
                    if currentGameState == .mainScreen {
                        withAnimation { self.colorPalette.changeHue() }
                    }
                } label: {
                Image(systemName: "arrowtriangle.right.fill")
                    .resizable()
                    .frame(width: measureUnit/2, height: measureUnit/2, alignment: .center)
                    
            }
            .foregroundColor(.white.opacity(0.5))
            .background(Circle().foregroundColor(colorPalette.secondary).frame(width: measureUnit, height: measureUnit, alignment: .center))
               
           }
            
       }
        .background(Rectangle()
            .frame(width: screenWidth, height: screenHeight+20, alignment: .center)
            .foregroundColor(colorPalette.primary))
        
        
    }
    
    func startGame() {
        print("- Starting the game...")
        self.currentGameState = .playing
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
        Group {
            ContentView()
                .previewDevice("iPhone 8")
            ContentView()
                .previewDevice("iPad Pro (9.7-inch)")
        }
    }
}
