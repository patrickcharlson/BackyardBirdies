//
//  Bird.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 13/07/2025.
//

import SwiftData
import Foundation

@Model
public class Bird {
    @Attribute(.unique) public var id: String
    public var creationDate: Date
    public var species: BirdSpecies?
    public var tag: String?
    public var lastKnowVisit: Date?
    public var colors: BirdPalette
    
    public var backgroundTimeInterval: Double
    
    public var speciesName: String { species?.info.name ?? "- Species name is missing. -"}
    
    public init(creationDate: Date = .now, colors: BirdPalette, tag: BirdTag? = nil, backgroundTimeInterval: TimeInterval = TimeInterval(hours: 10)) {
        self.id = UUID().uuidString
        self.creationDate = creationDate
        self.colors = colors
        self.tag = tag?.rawValue
        self.backgroundTimeInterval = backgroundTimeInterval
        
    }
}

public enum BirdTag: String, Codable, Hashable {
    case classicGreenHummingbird
    case premiumGoldHummingbird
}
