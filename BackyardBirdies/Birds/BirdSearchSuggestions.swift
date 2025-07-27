//
//  BirdSearchSuggestions.swift
//  BackyardBirdies
//
//  Created by Patrick Charlson on 27/7/2025.
//

import SwiftUI
import SwiftData

struct BirdSearchSuggestions: View {
    @Query private var birds: [Bird]
    
    var speciesNames: [String] {
        Set(birds.map(\.speciesName)).sorted()
    }
    
    var body: some View {
        ForEach(speciesNames, id: \.self) { speciesName in
            Text("**\(speciesName)**")
                .searchCompletion(speciesName)
        }
    }
}
