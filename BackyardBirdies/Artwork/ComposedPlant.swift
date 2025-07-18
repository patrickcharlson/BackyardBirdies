//
//  ComposedPlant.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 18/07/2025.
//

import SwiftUI

struct ComposedPlant: View {
    var plant: Plant
    
    public init(plant: Plant) {
        self.plant = plant
    }
    
    public var body: some View {
        ZStack {
            if let species = plant.species {
                ForEach(species.parts) { part in
                    if let imageName = imageName(for: part) {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                    } else {
                        Image(systemName: "questionmark")
                    }
                }
            }
        }
    }
    
    func imageName(for part: PlantPart) -> String? {
        guard let species = plant.species else { return nil }
        
        var result = "\(species.id)/\(part.name)"
        if part.variants != nil {
            result.append(" \(plant.variant + 1)")
        }
        return result
    }
}

