//
//  NewBirdIndicatorCard.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 13/07/2025.
//

import SwiftUI
import SwiftData

struct NewBirdIndicatorCard: View {
    @Query(sort: \Backyard.creationDate)
    private var backyards: [Backyard]
    
    var body: some View {
        if let backyard = backyards.first, let bird = backyard.currentVisitorEvent?.bird {
            HStack {
                NewBirdIndicator()
                VStack(alignment: .leading) {
                    Text("\(bird.speciesName) is visiting", comment: "Variable is a bird species")
//                        .font(.headline)
                    Text("Arrived in \(backyard.name)", comment: "Variable is a backyard name")
//                        .font(.callout)
//                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    NewBirdIndicatorCard()
        .backyardBirdsDataContainer(inMemory: true)
    
}
