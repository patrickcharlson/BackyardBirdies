//
//  Backyard+DataGeneration.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 12/07/2025.
//

import SwiftData
import OSLog

private let logger = Logger(subsystem: "BackyardBirdies", category: "Backyard")

extension Backyard {
    static func generateAll(modelContext: ModelContext) {
        var random = SeededRandomGenerator(seed: 8)
        
        logger.info("Generating All Backyards...")
        let allPlantSpecies = try! modelContext.fetch(FetchDescriptor<PlantSpecies>())
        
        logger.info("Generating first backyard...")
        let backyard1 = Backyard(name: String(localized: "Bird Springs", table: "Backyards"))
        modelContext.insert(backyard1)
        backyard1.isFavorite = true
        backyard1.timeIntervalOffset = TimeInterval(hours: 8)
        backyard1.leadingPlants = [
            .generateAndInsert(species: allPlantSpecies.randomElement(using: &random)!, modelContext: modelContext, random: &random),
            .generateAndInsert(species: allPlantSpecies.randomElement(using: &random)!, modelContext: modelContext, random: &random),
            .generateAndInsert(species: allPlantSpecies.randomElement(using: &random)!, modelContext: modelContext, random: &random)
        ]
        backyard1.trailingPants = [
            .generateAndInsert(species: allPlantSpecies.randomElement(using: &random)!, modelContext: modelContext, random: &random),
            .generateAndInsert(species: allPlantSpecies.randomElement(using: &random)!, modelContext: modelContext, random: &random),
            .generateAndInsert(species: allPlantSpecies.randomElement(using: &random)!, modelContext: modelContext, random: &random)
        ]
        
        if DataGenerationOptions.firstBackyardLowOnWater {
            backyard1.waterRefillDate = Date(timeIntervalSinceNow: -BackyardSupplies.water.durationUntilLow)
        } else {
            backyard1.waterRefillDate = Date(timeIntervalSinceNow: -BackyardSupplies.food.durationUntilLow * 0.6)
        }
        backyard1.floorVariant = .random(in: 0..<4, using: &random)
        backyard1.fountainVariant = .random(in: 0..<3, using: &random)
        backyard1.leadingSilhoutteVariant = .random(in: 0..<10, using: &random)
        backyard1.trailingSilhoutteVariant = .random(in: 0..<10, using: &random)
        
        logger.info("Backyards generated...")
        
        func generateRandomBackyard(name: String, timeOffset: Double) {
            let backyard = Backyard(name: name)
            modelContext.insert(backyard)
            backyard.timeIntervalOffset = timeOffset
            backyard.leadingPlants = (0..<3).map { _ in
                    .generateAndInsert(species: allPlantSpecies.randomElement(using: &random)!, modelContext: modelContext, random: &random)
            }
            
            backyard.trailingPants = (0..<3).map{ _ in
                    .generateAndInsert(species: allPlantSpecies.randomElement(using: &random)!, modelContext: modelContext, random: &random)
            }
        }
        
        generateRandomBackyard(name: String(localized: "Feathered Friends", table: "Backyards"), timeOffset: TimeInterval(hours: 12))
        generateRandomBackyard(name: String(localized: "Calm Palms", table: "Backyards"), timeOffset: TimeInterval(20))
        generateRandomBackyard(name: String(localized: "Chirp Center", table: "Backyards"), timeOffset: TimeInterval(21))
        generateRandomBackyard(name: String(localized: "Quiet Haven", table: "Backyards"), timeOffset: TimeInterval(6))
        
        logger.info("Backyards generated")
    }
}
