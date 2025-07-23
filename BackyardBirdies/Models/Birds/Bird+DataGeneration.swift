//
//  Bird+DataGeneration.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 14/07/2025.
//

import Foundation
import SwiftData


extension Bird {
    static func generateAll(modelContext: ModelContext) {
        var random = SeededRandomGenerator(seed: 1)
        
        let allBirdSpecies = try! modelContext.fetch(FetchDescriptor<BirdSpecies>())
        
        let hummingbirdSpecies = allBirdSpecies.first(where: { $0.info == .hummingbird })!
        
        do {
            let bird = Bird(
                creationDate: .init(timeIntervalSinceNow: -5),
                colors: .hummingbirdPalettes[0],
                tag: .classicGreenHummingbird,
                backgroundTimeInterval: TimeInterval(hours: 12)
            )
            
            modelContext.insert(bird)
            bird.species = hummingbirdSpecies
        }
        
        
        do {
            let bird = Bird(
                creationDate: .init(timeIntervalSinceNow: -3),
                colors: .hummingbirdPalettes[2],
                tag: .premiumGoldHummingbird,
                backgroundTimeInterval: TimeInterval(hours: 12)
            )
            
            modelContext.insert(bird)
            bird.species = hummingbirdSpecies
        }
        
        for species in allBirdSpecies {
            generateBird(species: species)
        }
        
        for species in allBirdSpecies {
            let total = Int.random(in: 5..<8, using: &random)
            for _ in 0..<total {
                generateBird(species: species)
            }
        }
        
        func generateBird(species: BirdSpecies) {
            let bird = Bird(
                colors: .generateColors(info: species.info, random: &random),
                backgroundTimeInterval: .random(in: 0..<TimeInterval(days: 1), using: &random))
            modelContext.insert(bird)
            bird.species = species
        }
    }
}
