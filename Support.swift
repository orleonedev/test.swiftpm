//
//  File.swift
//  test
//
//  Created by Oreste Leone on 16/04/22.
//

import Foundation
import SwiftUI

enum GameState {
    case mainScreen
    case preparation
    case playing
    case gameOver
}

var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
var screenHeight: CGFloat { UIScreen.main.bounds.size.height }

var GMUnit: CGFloat {screenWidth/5.0}
var displayWidth: CGFloat {screenWidth-(screenWidth/8)}
var displayHeight: CGFloat {screenHeight-(screenHeight/4)}

enum GumiPositions {
    case left, center, right
}


class ColorPalette:ObservableObject{
    
    static let sharedPalette: ColorPalette = ColorPalette()
    
    private enum NumberPal: CaseIterable {
        case first,second
        
        mutating func next() {
                let allCases = type(of: self).allCases
            self = allCases[(allCases.firstIndex(of: self)! + 1) % allCases.count]
            }
        
    }
    
    @Published var primary: Color = Color.cyan
    @Published var secondary: Color = Color.orange
    private var pal: NumberPal {
        willSet{
            switch newValue {
            case .first:
                self.primary = Color.cyan
                self.secondary = Color.orange
            case .second:
                self.primary = Color.pink
                self.secondary = Color.yellow
            }
        }
    }
    
    
    init(){
        
        self.pal = .first
        
    }
    
    
    func changeHue(){
        self.pal.next()
    }
    
}

