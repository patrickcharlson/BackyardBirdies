//
//  BirdSpeciesInfo.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 14/07/2025.
//

import Foundation

public struct BirdSpeciesInfo: Codable, CaseIterable, Hashable, RawRepresentable {
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public static var allCases: [BirdSpeciesInfo] = [
        .swallow, .dove, .chickadee, .petrel, .cardinal, .hummingbird
    ]
    
    public static let swallow = Self(rawValue: "Bird 1")
    public static let dove = Self(rawValue: "Bird 2")
    public static let chickadee = Self(rawValue: "Bird 3")
    public static let petrel = Self(rawValue: "Bird 4")
    public static let cardinal = Self(rawValue: "Bird 5")
    public static let hummingbird = Self(rawValue: "Bird 6")
    
    public var name: String {
        switch self {
        case .swallow:
            String(localized: "Swallow", table: "Birds", comment: "Bird 1 name")
        case .dove:
            String(localized: "Dove", table: "Birds", comment: "Bird 2 name")
        case .chickadee:
            String(localized: "Chickadee", table: "Birds", comment: "Bird 3 name")
        case .petrel:
            String(localized: "Petrel", table: "Birds", comment: "Bird 4 name")
        case .cardinal:
            String(localized: "Cardinal", table: "Birds", comment: "Bird 5 name")
        case .hummingbird:
            String(localized: "Hummingbird", table: "Birds", comment: "Bird 6 name")
        default:
            fatalError()
        }
    }
}
