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
                    leftPressed()
                } label: {
                Image(systemName: "arrowtriangle.left.fill")
                    .resizable()
                    .frame(width: GMUnit/1.8, height: GMUnit/1.8, alignment: .center)
                    
            }
            .foregroundColor(.white.opacity(0.5))
            .background(Circle().foregroundColor(shared.secondary).frame(width: GMUnit, height: GMUnit, alignment: .center))
                
               Button {
                   centerPressed()
           } label: {
               Image(systemName: "star.fill")
                   .resizable()
                   .frame(width: GMUnit/1.6, height: GMUnit/1.6, alignment: .center)
                   
           }
           .foregroundColor(.white.opacity(0.5))
           .background(Circle().foregroundColor(shared.secondary).frame(width: GMUnit, height: GMUnit, alignment: .center))
                
                Button {
                    rightPressed()
                } label: {
                Image(systemName: "arrowtriangle.right.fill")
                    .resizable()
                    .frame(width: GMUnit/1.8, height: GMUnit/1.8, alignment: .center)
                    
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
    
    func leftPressed(){
        switch currentGameState {
        case .mainScreen:
            withAnimation { shared.changeHue() }
        case .preparation:
            self.currentGameState = .mainScreen
        case .playing:
            GameLogic.shared.changeGumiPosition(.left)
        case .gameOver:
            self.currentGameState = .mainScreen
        }
    }
    
    func rightPressed(){
        switch currentGameState {
        case .mainScreen:
            withAnimation { shared.changeHue() }
        case .preparation:
            self.currentGameState = .mainScreen
        case .playing:
            GameLogic.shared.changeGumiPosition(.right)
        case .gameOver:
            self.currentGameState = .mainScreen
        }
    }
    
    func centerPressed(){
        switch currentGameState {
        case .mainScreen:
            withAnimation { self.startPreparation() }
        case .preparation:
            withAnimation { self.startGame() }
        case .playing:
            GameLogic.shared.changeGumiPosition(.center)
        case .gameOver:
            self.currentGameState = .mainScreen
        }
    }
}


