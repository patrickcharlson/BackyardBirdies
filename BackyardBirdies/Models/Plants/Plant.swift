//
//  Plant.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 16/07/2025.
//

import Foundation
import SwiftData

@Model public class Plant {
    @Attribute(.unique) public var id: String
    public var creationDate: Date
    public var variant: Int
    public var backyard: Backyard?
    public var species: PlantSpecies?
    
    public init(id: UUID = UUID(), variant: Int) {
        self.id = id.uuidString
        self.variant = variant
        self.creationDate = .now
    }
}
