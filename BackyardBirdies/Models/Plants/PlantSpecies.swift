//
//  PlantSpecies.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 16/07/2025.
//

import Foundation
import SwiftData

@Model public class PlantSpecies {
    @Attribute(.unique) public var id: String
    var parts: [PlantPart]
    
    @Relationship(deleteRule: .cascade, inverse: \Plant.species)
    var plants: [Plant] = []
    
    var info: PlantSpeciesInfo {
        PlantSpeciesInfo(rawValue: id)
    }
    
    init(info: PlantSpeciesInfo, parts: [PlantPart]) {
        self.id = info.rawValue
        self.parts = parts
    }
}
