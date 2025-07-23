//
//  BirdsSearchResults.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 22/07/2025.
//

import SwiftUI
import SwiftData

struct BirdsSearchResults<Content: View>: View {
    @Binding var searchText: String
    @Query private var birds: [Bird]
    private var content: (Bird) -> Content
    
    init(searchText: Binding<String>, @ViewBuilder content: @escaping (Bird) -> Content) {
        _searchText = searchText
        _birds = Query(sort: \.creationDate)
        self.content = content
    }
    
    var body: some View {
        if $searchText.wrappedValue.isEmpty {
            ForEach(birds, content: content)
        } else {
            ForEach(birds.filter {
                $0.speciesName.contains($searchText.wrappedValue)
            }, content: content)
        }
    }
}

