//
//  BirdSpecies.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 14/07/2025.
//

import Foundation
import SwiftData
import Observation

@Model public class BirdSpecies {
    @Attribute(.unique) public var id: String
    public var naturalScale: Double
    public var isEarlyAccess: Bool
    public var parts: [BirdPart] = []
    
    @Relationship(deleteRule: .cascade, inverse: \Bird.species)
    public var birds: [Bird] = []
    
    public var info: BirdSpeciesInfo { BirdSpeciesInfo(rawValue: id) }
    
    
    public init(info: BirdSpeciesInfo, naturalScale: Double = 1, isEarlyAccess: Bool = false, parts: [BirdPart]) {
        self.id = info.rawValue
        self.naturalScale = naturalScale
        self.isEarlyAccess = isEarlyAccess
        self.parts = parts
    }
}
