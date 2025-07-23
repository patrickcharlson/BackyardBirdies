//
//  BirdsScreen.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 12/07/2025.
//

import SwiftUI

struct BirdsScreen: View {
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [.init(.adaptive(minimum: 110), alignment: .top)], spacing: 20) {
                    BirdsSearchResults(searchText: $searchText) { bird in
                        BirdGridItem(bird: bird)
                    }
                }
            }
        }
    }
}

#Preview {
    BirdsScreen()
}
