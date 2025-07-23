//
//  BirdPalette.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 23/07/2025.
//

import Foundation

public struct BirdPalette: Codable {
     var body: ColorData
     var wing: ColorData
     var beak: ColorData
     var belly: ColorData
     var accent: ColorData
    
    init(body: ColorData, wing: ColorData? = nil, beak: ColorData, belly: ColorData = .white, accent: ColorData = .white) {
        self.body = body
        self.wing = wing ?? body
        self.beak = beak
        self.belly = belly
        self.accent = accent
    }
    
    public func colorData(for colorStyleRawValue: Int) -> ColorData {
        let colorStyle = BirdPartColorStyle(rawValue: colorStyleRawValue)
        switch colorStyle {
        case .body: return body
        case .wing: return wing
        case .belly: return belly
        case .accent: return accent
        case .beak: return beak
        case .white: return .white
        case .black: return .birdBlack
        default:
            fatalError("I didn't know a bird had that part!")
        }
    }
}

public struct BirdPartColorStyle: Codable, Hashable {
    var rawValue: Int = 0
        
    static let body = Self(rawValue: 0)
    static let wing = Self(rawValue: 1)
    static let belly = Self(rawValue: 2)
    static let accent = Self(rawValue: 3)
    static let beak = Self(rawValue: 4)
    static let white = Self(rawValue: 5)
    static let black = Self(rawValue: 6)
    
    static let allCases: [BirdPartColorStyle] = [
        .body, .wing, .belly, .accent, .beak, .white, .black
    ]
    
}
