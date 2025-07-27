//
//  PlantsSearchResults.swift
//  BackyardBirdies
//
//  Created by Patrick Charlson on 27/7/2025.
//

import SwiftUI
import SwiftData

struct PlantsSearchResults: View {
    @Binding var searchText: String
    @Query private var plants: [Plant]
    
    init(searchText: Binding<String>) {
        _searchText = searchText
        _plants = Query(sort: \.creationDate)
    }
    
    var body: some View {
        if $searchText.wrappedValue.isEmpty {
            ForEach(plants) { plant in
                PlantSummaryRow(plant: plant)
            }
        } else {
            ForEach(plants.filter {
                $0.speciesName.contains($searchText.wrappedValue)
            }, content: {
                PlantSummaryRow(plant: $0)
            })
        }
    }
}
