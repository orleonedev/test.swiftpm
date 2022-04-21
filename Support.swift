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

var GMUnit: CGFloat {screenWidth/6}
var displayWidth: CGFloat {screenWidth-(screenWidth/8)}
var displayHeight: CGFloat {screenHeight-(screenHeight/4)}

enum GumiPositions {
    case left, center, right
}




