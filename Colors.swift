//
//  File.swift
//  GumiEats
//
//  Created by Oreste Leone on 20/04/22.
//

import Foundation
import SwiftUI

class ColorPalette: ObservableObject{
    
    static let sharedPalette: ColorPalette = ColorPalette()
    
    private enum NumberPal: CaseIterable {
        case first,second,third,fourth
        
        mutating func next() {
                let allCases = type(of: self).allCases
            self = allCases[(allCases.firstIndex(of: self)! + 1) % allCases.count]
            }
        
    }
    
    private var primaryStored: String? {
        get{
            return UserDefaults.standard.string(forKey: "Primary")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "Primary")
            self.primary = Color(newValue ?? "primary1")
        }
    }
    
    private var secondaryStored: String? {
        get{
            return UserDefaults.standard.string(forKey: "Secondary")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "Secondary")
            self.secondary = Color(newValue ?? "secondary1")
        }
    }
    
    @Published var primary: Color = Color(UserDefaults.standard.string(forKey: "Primary") ?? "primary1")
    @Published var secondary: Color? = Color(UserDefaults.standard.string(forKey: "Secondary") ?? "secondary1")
    
    private var pal: NumberPal {
        willSet{
            switch newValue {
            case .first:
                self.primaryStored = "primary1"
                self.secondaryStored = "secondary1"
            case .second:
                self.primaryStored = "primary2"
                self.secondaryStored = "secondary2"
            case .third:
                self.primaryStored = "primary3"
                self.secondaryStored = "secondary3"
            case .fourth:
                self.primaryStored = "primary4"
                self.secondaryStored = "secondary4"
            }
        }
    }
    
    init(){
        switch UserDefaults.standard.string(forKey: "Primary"){
        case "primary2":
            pal = .second
        case "primary3":
            pal = .third
        case "primary4":
            pal = .fourth
        default:
            pal = .first
        }
    }
    
    
    func changeHue(){
        self.pal.next()
    }
    
}
