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
                        .font(.headline)
                    Text("Arrived in \(backyard.name)", comment: "Variable is a backyard name")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.forward")
                    .font(.subheadline.bold())
                    .foregroundStyle(.tertiary)
                    .frame(width: 30)
            }
            .padding(12)
            .background(.fill.tertiary, in: .capsule)
            .frame(maxWidth: 400)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ZStack {
        NewBirdIndicatorCard()
    }
    .backyardBirdsDataContainer(inMemory: true)
}
