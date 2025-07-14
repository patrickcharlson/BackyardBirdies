//
//  BirdSpecies+DataGeneration.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 14/07/2025.
//

import OSLog
import SwiftData

private let logger = Logger(subsystem: "BackyardBirdsData", category: "BirdSpecies")

extension BirdSpecies {
    static func generateAll(modelContext: ModelContext) {
        logger.info("Generating all bird species")
        
        modelContext.insert(BirdSpecies(
            info: .swallow,
            naturalScale: 0.83,
        ))
        
        modelContext.insert(BirdSpecies(
            info: .dove,
            naturalScale: 1,
        ))
        
        modelContext.insert(BirdSpecies(
            info: .chickadee,
            naturalScale: 0.71,
            isEarlyAccess: true,
        ))
        
        modelContext.insert(BirdSpecies(
            info: .petrel,
            naturalScale: 1,
        ))
        
        modelContext.insert(BirdSpecies(
            info: .cardinal,
            naturalScale: 1,
        ))
        
        modelContext.insert(BirdSpecies(
            info: .hummingbird,
            naturalScale: 0.76,
        ))
        
        logger.info("Generated bird species")

    }
}
