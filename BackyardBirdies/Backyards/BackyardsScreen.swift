//
//  BackyardsScreen.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 12/07/2025.
//

import SwiftUI
import SwiftData

struct BackyardsScreen: View {
    @Query(sort: \Backyard.creationDate)
    private var backyards: [Backyard]
    
    var body: some View {
        NavigationStack {
            BackyardGrid()
                .navigationTitle("Backyards")
                .navigationDestination(for: Backyard.ID.self) { backyardID in
                    if let backyard = backyards.first(where: { $0.id == backyardID }) {
                        BackyardDetailView(backyard: backyard)
                    }
                }
        }
    }
}

#Preview {
    BackyardsScreen()
        .backyardBirdsDataContainer(inMemory: true)
}
