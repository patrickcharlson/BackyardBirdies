//
//  PlantsScreen.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 12/07/2025.
//

import SwiftUI

struct PlantsScreen: View {
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 110), alignment: .top)], spacing: 20) {
                    PlantsSearchResults(searchText: $searchText)
                }
            }
            .searchable(text: $searchText)
            .searchSuggestions {
                if searchText.isEmpty {
                    PlantsSearchSuggestions()
                }
            }
            .contentMargins(20, for: .scrollContent)
            .navigationTitle("Plants")
        }
    }
}

#Preview {
    PlantsScreen()
        .backyardBirdsDataContainer(inMemory: true)
}
