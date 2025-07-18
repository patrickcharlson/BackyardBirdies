//
//  PlantSpecies+DataGeneration.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 16/07/2025.
//

import Foundation
import SwiftData

extension PlantSpecies {
    static func generateAll(modelContext: ModelContext) {
        modelContext.insert(PlantSpecies(
            info: .foxglove,
            parts: [
                .pot(),
                .plant()
            ]
        ))
        
        modelContext.insert(PlantSpecies(
            info: .snakePlant,
            parts: [
                .plant(),
                .pot()
            ]
        ))
        
        modelContext.insert(PlantSpecies(
            info: .colocasia,
            parts: [
                .plant(),
                .pot()
            ]
        ))
        
        modelContext.insert(PlantSpecies(
            info: .kentiaPalm,
            parts: [
                .plant(),
                .pot()
            ]
        ))
        
        modelContext.insert(PlantSpecies(
            info: .alocasia,
            parts: [
                .plant(),
                .pot()
            ]
        ))
        
    }
}
