import SwiftUI

@main
struct MyApp: App {
    
    init(){
        MyFonts.registerFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
    }
}
