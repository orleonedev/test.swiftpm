import SwiftUI


struct ContentView: View {
    
    @State var currentGameState: GameState = .mainScreen
    @StateObject var gameLogic: GameLogic = GameLogic()
    @StateObject var colorPalette: ColorPalette = ColorPalette()
    @StateObject var shared = ColorPalette.sharedPalette
    
    var body: some View {
        
        VStack(alignment: .center, spacing: GMUnit/2){
           
           ZStack{
               switch currentGameState {
               case .mainScreen:
                   MainScreenView(currentGameState: $currentGameState)
               case .preparation:
                   PreparationView(currentGameState: $currentGameState)
                       .environmentObject(gameLogic)
                       .environmentObject(colorPalette)
               case .playing:
                   GameView(currentGameState: $currentGameState)
                       .environmentObject(gameLogic)
                       .environmentObject(colorPalette)
               
               case .gameOver:
                   GameOverView(currentGameState: $currentGameState)
                       .environmentObject(gameLogic)
                       .environmentObject(colorPalette)
               }
            
           }
           .frame(width: displayWidth, height: displayHeight, alignment: .center)
           
            HStack(alignment: .center, spacing: GMUnit) {
               
                Button {
                    if currentGameState == .mainScreen {
                        withAnimation { shared.changeHue() }
                    }
                } label: {
                Image(systemName: "arrowtriangle.left.fill")
                    .resizable()
                    .frame(width: GMUnit/2, height: GMUnit/2, alignment: .center)
                    
            }
            .foregroundColor(.white.opacity(0.5))
            .background(Circle().foregroundColor(shared.secondary).frame(width: GMUnit, height: GMUnit, alignment: .center))
                
               Button {
               if currentGameState == .mainScreen {
                   withAnimation { self.startPreparation() }
               }
               
           } label: {
               Image(systemName: "star.fill")
                   .resizable()
                   .frame(width: GMUnit/2, height: GMUnit/2, alignment: .center)
                   
           }
           .foregroundColor(.white.opacity(0.5))
           .background(Circle().foregroundColor(shared.secondary).frame(width: GMUnit, height: GMUnit, alignment: .center))
                
                Button {
                    if currentGameState == .mainScreen {
                        withAnimation { shared.changeHue() }
                    }
                } label: {
                Image(systemName: "arrowtriangle.right.fill")
                    .resizable()
                    .frame(width: GMUnit/2, height: GMUnit/2, alignment: .center)
                    
            }
            .foregroundColor(.white.opacity(0.5))
            .background(Circle().foregroundColor(shared.secondary).frame(width: GMUnit, height: GMUnit, alignment: .center))
               
           }
            
       }
        .background(
            Rectangle()
            .frame(width: screenWidth, height: screenHeight+20, alignment: .center)
            .foregroundColor(shared.primary)
        )
        
        
    }
    
    func startPreparation(){
        print("- Preparing...")
        self.currentGameState = .preparation
    }
    
    func startGame() {
        print("- Starting the game...")
        self.currentGameState = .playing
    }
}

