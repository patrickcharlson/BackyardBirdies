//
//  BackyardVisitorEvent+DataGeneration.swift
//  BackyardBirdies
//
//  Created by Patrick Charlson on 3/8/2025.
//

import Foundation
import SwiftData
import OSLog

private let logger = Logger(subsystem: "BackyardBirdsData", category: "BackyardVisitorEvent")

extension BackyardVisitorEvent {
    static func generateHistoricalEvents(modelContext: ModelContext, includeEarlyAccessSpecies: Bool) {
        var random = SeededRandomGenerator(seed: 1)
        
        logger.info("Generating historical visitor events")
        let birds =  try! modelContext.fetch(FetchDescriptor<Bird>())
            .shuffled(using: &random)
            .filter { includeEarlyAccessSpecies || !($0.species?.isEarlyAccess ?? false) }
        let backyards = try! modelContext.fetch(FetchDescriptor<Backyard>())
        
        for minutesAgo in stride(from: 5, through: 300, by: 40) {
            for (backyard, bird) in zip(backyards, birds.shuffled(using: &random)) {
                let date = Date.now.addingTimeInterval(TimeInterval(minutes: -Double(minutesAgo)))
                let event = BackyardVisitorEvent(
                    startDate: date,
                    duration: .random(in: 5...30, using: &random))
                modelContext.insert(event)
                event.backyard = backyard
                event.bird = bird
                backyard.visitorEvents.insert(event, at: 0)
                bird.updateVisitStatus(visitedOn: date)
            }
        }
        
        logger.info("Finished generating historical visitor events")
    }
}
