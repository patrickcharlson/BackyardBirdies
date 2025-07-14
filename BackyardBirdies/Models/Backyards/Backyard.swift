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
    public var creationDate: Date
    
    public var currentVisitorEvent: BackyardVisitorEvent? {
        guard let event = visitorEvents.first(where: { $0.dateRange.contains(.now) }) else {
            return nil
        }
        return event
    }
    
    
    public init(name: String?) {
        self.id = UUID().uuidString
        self.name = name ?? String(localized: "Backyard", table: "backyards")
        self.waterRefillDate = .now
        self.creationDate = .now
        self.isFavorite = false
    }
}
