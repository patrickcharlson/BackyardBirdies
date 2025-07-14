//
//  DataGeneration.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 12/07/2025.
//

import SwiftData
import Foundation
import OSLog

private let logger = Logger(subsystem: "BackyardBirdsData", category: "DataGeneration")

@Model
public class DataGeneration {
    public var initializationDate: Date?
    public var lastSimulationDate: Date?
    
    @Transient public var includeEarlyAccessSpecies: Bool = false
    
    public var requiresInitialDataGeneration: Bool {
        initializationDate == nil
    }
    
    public init(initializationDate: Date?, lastSimulationDate: Date?, includeEarlyAccessSpecies: Bool = false) {
        self.initializationDate = initializationDate
        self.lastSimulationDate = lastSimulationDate
        self.includeEarlyAccessSpecies = includeEarlyAccessSpecies
    }
    
    private func simulateHistoricalEvents(modelContext: ModelContext) {
        logger.info("Attempting to simulate historical events...")
        if requiresInitialDataGeneration {
            logger.info("Requires an initial data generation")
            generateInitialData(modelContext: modelContext)
        }
    }
    
    private func generateInitialData(modelContext: ModelContext) {
        logger.info("Generating initial data...")
        
        logger.info("Generating all bird species")
        BirdSpecies.generateAll(modelContext: modelContext)
        
        logger.info("Generating initial instances of all birds")
        Bird.generateAll(modelContext: modelContext)
        
        logger.info("Generating initial instances of backyards")
        Backyard.generateAll(modelContext: modelContext)
        initializationDate = .now
    }
    
    private static func instance(with modelContext: ModelContext) -> DataGeneration {
        if let result = try! modelContext.fetch(FetchDescriptor<DataGeneration>()).first {
            return result
        } else {
            let instance = DataGeneration(
                initializationDate: nil,
                lastSimulationDate: nil
            )
            modelContext.insert(instance)
            return instance
        }
    }
    
    public static func generateAllData(modelContext: ModelContext) {
        let instance = instance(with: modelContext)
        logger.info("Attempting to statically simulate historical events...")
        instance.simulateHistoricalEvents(modelContext: modelContext)
    }
}

public extension DataGeneration {
    static let schema = SwiftData.Schema([
        DataGeneration.self,
        BirdSpecies.self,
        Bird.self,
        Backyard.self,
    ])
}
