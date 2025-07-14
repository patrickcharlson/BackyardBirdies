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
//        var random = SeededRandomGenerator(seed: 8)
        logger.info("Generating All Backyards...")
        logger.info("Generating first backyard...")
        let backyard1 = Backyard(name: String(localized: "Bird Springs", table: "Backyards"))
        modelContext.insert(backyard1)
        backyard1.isFavorite = true
        
        if DataGenerationOptions.firstBackyardLowOnWater {
            backyard1.waterRefillDate = Date(timeIntervalSinceNow: -BackyardSupplies.water.durationUntilLow)
        } else {
            backyard1.waterRefillDate = Date(timeIntervalSinceNow: -BackyardSupplies.food.durationUntilLow * 0.6)
        }
        
        logger.info("Backyards generated...")
        
        func generateRandomBackyard(name: String, timeOffset: Double) {
            let backyard = Backyard(name: name)
            modelContext.insert(backyard)
        }
        
        generateRandomBackyard(name: String(localized: "Feathered Friends", table: "Backyards"), timeOffset: TimeInterval(hours: 12))
        generateRandomBackyard(name: String(localized: "Calm Palms", table: "Backyards"), timeOffset: TimeInterval(20))
        generateRandomBackyard(name: String(localized: "Chirp Center", table: "Backyards"), timeOffset: TimeInterval(21))
        generateRandomBackyard(name: String(localized: "Quiet Haven", table: "Backyards"), timeOffset: TimeInterval(6))
    }
}
