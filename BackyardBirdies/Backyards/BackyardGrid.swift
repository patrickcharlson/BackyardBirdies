//
//  BackyardGrid.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 13/07/2025.
//

import SwiftUI

struct BackyardGrid: View {
    @State private var searchText = ""
    
    var body: some View {
        ScrollView {
            if presentingNewBirdIndicatorCard {
                NewBirdIndicatorCard()
            }
            
            LazyVGrid(columns: [.init(.adaptive(minimum: 300))]) {
                BackyardsSearchResults(searchText: $searchText)
            }
        }
    }
    
    /// A Boolean value indicating whether the new bird indicator card should be presented in the view.
    ///
    /// This property checks the `showNewBirdIndicatorCard` static property from `DataGenerationOptions`
    /// to determine if the `NewBirdIndicatorCard` should be displayed at the top of the grid.
    var presentingNewBirdIndicatorCard: Bool {
        DataGenerationOptions.showNewBirdIndicatorCard
    }
}

#Preview {
    BackyardGrid()
}
