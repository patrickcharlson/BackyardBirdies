//
//  Backyard.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 12/07/2025.
//

import Foundation
import SwiftData

@Model
public class Backyard {
    @Attribute(.unique) public var id: String
    public var name: String
    public var waterRefillDate: Date
    public var isFavorite: Bool
    public var visitorEvents: [BackyardVisitorEvent] = []
    public var timeIntervalOffset: TimeInterval
    public var creationDate: Date
    public var presentingVisitor: Bool
    
    @Relationship(inverse: \Plant.backyard)
    public var leadingPlants: [Plant] = []
    
    @Relationship(inverse: \Plant.backyard)
    public var trailingPants: [Plant] = []
    
    public var floorVariant: Int
    public var fountainVariant: Int
    public var leadingSilhoutteVariant: Int
    public var trailingSilhoutteVariant: Int
    public var leadingForegroundPlantVariant: Int
    public var trailingForegroundPlantVariant: Int
    
    public var currentVisitorEvent: BackyardVisitorEvent? {
        guard let event = visitorEvents.first(where: { $0.dateRange.contains(.now) }) else {
            return nil
        }
        return event
    }
    
    public var hasVisitor: Bool {
        currentVisitorEvent != nil
    }
    
    public var needsToPresentVisitor: Bool {
        hasVisitor && !presentingVisitor
    }
    
    public var colorData: BackyardTimeOfDayColorData {
        BackyardTimeOfDayColorData.colorData(timeInterval: timeIntervalOffset - creationDate.timeIntervalSinceNow)
    }
    
    public init(name: String?) {
        self.id = UUID().uuidString
        self.name = name ?? String(localized: "Backyard", table: "backyards")
        self.waterRefillDate = .now
        self.creationDate = .now
        self.isFavorite = false
        self.presentingVisitor = false
        self.timeIntervalOffset = TimeInterval(hours: 12)
        self.floorVariant = 0
        self.fountainVariant = 0
        self.leadingSilhoutteVariant = 0
        self.trailingSilhoutteVariant = 0
        self.leadingForegroundPlantVariant = 0
        self.trailingForegroundPlantVariant = 0
    }
}
