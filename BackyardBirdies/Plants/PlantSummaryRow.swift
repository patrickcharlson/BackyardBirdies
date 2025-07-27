//
//  PlantSummaryRow.swift
//  BackyardBirdies
//
//  Created by Patrick Charlson on 27/7/2025.
//

import SwiftUI

struct PlantSummaryRow: View {
    var plant: Plant
    
    var body: some View {
        VStack {
            ComposedPlant(plant: plant)
                .padding(4)
                .padding(.bottom, -20)
                .clipShape(.circle)
                .background(.fill.tertiary, in: .circle)
                .padding(.horizontal, 10)
            
            VStack {
                Text(plant.speciesName)
                    .font(.callout)
            }
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    ModelPreview { plant in
        PlantSummaryRow(plant: plant)
    }
}
