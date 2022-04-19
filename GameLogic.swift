//
//  File.swift
//  test
//
//  Created by Oreste Leone on 16/04/22.
//
import Foundation

class GameLogic: ObservableObject {
    
    // Single instance of the class
    static let shared: GameLogic = GameLogic()
    
    var ingredients: [String] = ["🍎","🍐","🍊","🍋","🍌"]
    var wants: [String] = []
    var hates: [String] = []
    
    func initializeGame(){
        
        ingredients = ["🍎","🍐","🍊","🍋","🍌"]
        wants = []
        hates = []
        
        for _ in 0...2 {
            let index = Int.random(in: 0...ingredients.count-1)
            wants.append(ingredients.remove(at: index))
        }
        hates.append(contentsOf: ingredients)
    }
    
    // Function responsible to set up the game before it starts.
    func setUpGame() {
        
        // TODO: Customize!
        
        self.currentScore = 0
        self.sessionDuration = 0
        
        self.isGameOver = false
    }
    
    // Keeps track of the current score of the player
    @Published var currentScore: Int = 0
    
    // Increases the score by a certain amount of points
    func score(points: Int) {
        
        // TODO: Customize!
        
        self.currentScore = self.currentScore + points
    }
    
    // Keep tracks of the duration of the current session in number of seconds
    @Published var sessionDuration: TimeInterval = 0
    
    func increaseSessionTime(by timeIncrement: TimeInterval) {
        self.sessionDuration = self.sessionDuration + timeIncrement
    }
    
    func restartGame() {
        
        // TODO: Customize!
        
        self.setUpGame()
    }
    
    // Game Over Conditions
    @Published var isGameOver: Bool = false
    
    func finishTheGame() {
        if self.isGameOver == false {
            self.isGameOver = true
        }
    }
    
}
