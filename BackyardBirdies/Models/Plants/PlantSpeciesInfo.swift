//
//  PlantSpeciesInfo.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 16/07/2025.
//

import Foundation

struct PlantSpeciesInfo: Codable, CaseIterable, RawRepresentable, Hashable {
    var rawValue: String
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    static var allCases: [PlantSpeciesInfo] = [
        .foxglove, .snakePlant, .colocasia, .kentiaPalm, .alocasia
    ]
    
    static let foxglove = Self(rawValue: "Plant 1")
    static let snakePlant = Self(rawValue: "Plant 2")
    static let colocasia = Self(rawValue: "Plant 3")
    static let kentiaPalm = Self(rawValue: "Plant 4")
    static let alocasia = Self(rawValue: "Plant 5")
    
    var name: String {
        switch self {
        case .foxglove:
            String(localized: "Foxglove", table: "PlantSpecies", comment: "Plant 1 name")
        case .snakePlant:
            String(localized: "Snake Plant", table: "PlantSpecies", comment: "Plant 2 name")
        case .colocasia:
            String(localized: "Colocasia", table: "PlantSpecies", comment: "Plant 3 name")
        case .kentiaPalm:
            String(localized: "Kentia Palm", table: "PlantSpecies", comment: "Plant 4 name")
        case .alocasia:
            String(localized: "Alocasia", table: "PlantSpecies", comment: "Plant 5 name")
        default:
            fatalError()
        }
    }
    
}
