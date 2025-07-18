//
//  PlantView.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 18/07/2025.
//

import SwiftUI

struct PlantView: View {
    var plant: Plant
    var index: Int
    
    public init(plant: Plant, index: Int) {
        self.plant = plant
        self.index = index
    }
    
    var body: some View {
        ComposedPlant(plant: plant)
            .frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .bottom)
            .colorMultiply(.init(white: 1.0 - (0.1 * Double(2 - index))))
    }
}
