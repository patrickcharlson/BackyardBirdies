//
//  PlantsSearchSuggestions.swift
//  BackyardBirdies
//
//  Created by Patrick Charlson on 27/7/2025.
//

import SwiftUI
import SwiftData

struct PlantsSearchSuggestions: View {
    @Query private var plants: [Plant]
    
    var speciesNames: [String] {
        Set(plants.map(\.speciesName)).sorted()
    }
    var body: some View {
        ForEach(speciesNames, id: \.self) { speciesName in
            Text("**\(speciesName)**")
                .searchCompletion(speciesName)
        }
    }
}

#Preview {
    PlantsSearchSuggestions()
}
