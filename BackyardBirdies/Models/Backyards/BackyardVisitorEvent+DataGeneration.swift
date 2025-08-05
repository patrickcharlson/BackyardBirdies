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
    
    static func generateCurrentEvents(modelContext: ModelContext, includeEarlyAccessSpecies: Bool) {
        var random = SeededRandomGenerator(seed: 4)
        
        logger.info("Generating current visitor events")
        let allBirds =  try! modelContext.fetch(FetchDescriptor<Bird>())
            .filter { includeEarlyAccessSpecies || !($0.species?.isEarlyAccess ?? false) }
        let birds = allBirds.shuffled(using: &random)
        let firstHummingBird = allBirds.first(where: { ($0.species?.info ?? .dove) == .hummingbird })!
        let backyards = try! modelContext.fetch(FetchDescriptor<Backyard>())
        let firstBackyard = backyards.first!
        
        let duration = DataGenerationOptions.currentBirdsVisitingDuration
        
        for (bird, backyard) in zip(birds, backyards) {
            if backyard == firstBackyard, case .notVisiting = DataGenerationOptions.firstBackyardBirdStatus {
                continue
            }
            let bird = backyard == firstBackyard ? firstHummingBird : bird
            let event = BackyardVisitorEvent(startDate: .now, duration: duration)
            modelContext.insert(event)
            event.backyard = backyard
            event.bird = bird
            if backyard == firstBackyard {
                switch DataGenerationOptions.firstBackyardBirdStatus {
                case .alreadyVisible:
                    logger.info("Setting first bird to be initially visible")
                    backyard.presentingVisitor = true
                case .fliesIn:
                    logger.info("Setting first bird to fly in")
                    backyard.presentingVisitor = false
                case .notVisiting:
                    fatalError()
                }
                backyard.visitorEvents.append(event)
            } else {
                backyard.visitorEvents.append(event)
                backyard.presentingVisitor = true
            }
        }
        logger.info("Finished generating current events")
    }
}
