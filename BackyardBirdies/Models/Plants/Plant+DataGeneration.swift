//
//  Plant+DataGeneration.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 16/07/2025.
//

import SwiftData
import OSLog

private let logger = Logger(subsystem: "BackyardBirdsData", category: "Plant")

extension Plant {
    static func generateIndividualPlants(modelContext: ModelContext) {
        var random = SeededRandomGenerator(seed: 1)
        
        logger.info("Generating individual plants...")
        let allPlantSpecies = try! modelContext.fetch(FetchDescriptor<PlantSpecies>())
        logger.info("Found all plants species, now generating plants...")
        for species in allPlantSpecies {
            let count = Int.random(in: 1...3, using: &random)
            for _ in 0 ..< count {
                generateAndInsert(species: species, modelContext: modelContext, random: &random)
            }
        }
        logger.info("Completed generating individual plants.")
    }
    
    @discardableResult
    static func generateAndInsert(species: PlantSpecies, modelContext: ModelContext, random: inout SeededRandomGenerator) -> Plant {
        let variantCount = species.parts.compactMap(\.variants).first!
        let plant = Plant(variant: .random(in: 0..<variantCount, using: &random))
        modelContext.insert(plant)
        plant.species = species
        return plant
    }
}
