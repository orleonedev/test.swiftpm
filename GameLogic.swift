//
//  File.swift
//  test
//
//  Created by Oreste Leone on 16/04/22.
//
import Foundation
import UIKit

class GameLogic: ObservableObject {
    
    // Single instance of the class
    static let shared: GameLogic = GameLogic()
    
    var ingredients: [String] = ["Apple","Avocado","Broccoli","Carote","Cheese","Donuts","Egg","Fungo","Sweet","Tomato"]
    var wants: [String] = []
    var hates: [String] = []
    
    var hateGot: [String] = []
    var wantsGot: [String] = []
    var multiplier: Double = 2.0
    var randomColor: UIColor {
        switch Int.random(in: 0...3){
        case 0:
            return .green
        case 1:
            return .white
        case 2:
            return .red
        default:
            return .yellow
        }
    }
    var gumiColor: UIColor = .white
    
    
    var currentGumiPosition: GumiPositions = .center
    
    func changeGumiPosition(_ to: GumiPositions){
        currentGumiPosition = to
    }
    
    
    var stopCooking: Bool = false
    
    func initializeGame(){
        
        var temp: [String] = ingredients
        wants = []
        hates = []
        
        for _ in 0...2 {
            let index = Int.random(in: 0...temp.count-1)
            wants.append(temp.remove(at: index))
        }
        
        for _ in 0...1 {
            let index = Int.random(in: 0...temp.count-1)
            hates.append(temp.remove(at: index))
        }
        
        print("LOGIC Love: \(wants)")
        print("LOGIC Hates: \(hates)")
        gumiColor = randomColor
    }
    
    // Function responsible to set up the game before it starts.
    func setUpGame() {
        print("SETUP GAME")
        // TODO: Customize!
        self.currentGumiPosition = .center
        self.currentScore = 0
        self.sessionDuration = 45
        self.wantsGot = []
        self.hateGot = []
        self.ingredientCatchOver = false
        self.stopCooking = false
    }
    
    // Keeps track of the current score of the player
    @Published var currentScore: Int = 0
    
    // Increases the score by a certain amount of points
    func score(points: Int) {
        
        // TODO: Customize!
        
        self.currentScore = self.currentScore + points
        if self.currentScore < 0 { self.currentScore = 0}
    }
    
    @Published var finalScore: Int = 0
    
    func calculateFinalScore(distance: CGFloat) -> Int{
        return self.currentScore // da sistemare Accuracy positivo se poco cotto, negativo se troppo cotto bisogna puntare ad essere vicino a zero
    }
    
    var highestScore: Int {
        get {
            return UserDefaults.standard.integer(forKey: "HighScore")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "HighScore")
        }
    }
    
    // Keep tracks of the duration of the current session in number of seconds
    @Published var sessionDuration: TimeInterval = 45
    
    func decreaseSessionTime(by timeIncrement: TimeInterval) {
        self.sessionDuration = self.sessionDuration - timeIncrement
    }
    
    func restartGame() {
        
        // TODO: Customize!
        
        self.setUpGame()
    }
    
    // Game Over Conditions
    @Published var ingredientCatchOver: Bool = false
    
    func finishCatching() {
        if self.ingredientCatchOver == false {
            self.ingredientCatchOver = true
        }
    }
    
    
}
