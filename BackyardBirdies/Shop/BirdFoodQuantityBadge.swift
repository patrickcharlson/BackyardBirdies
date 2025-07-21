//
//  BirdFoodQuantityBadge.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 21/07/2025.
//

import SwiftUI

struct BirdFoodQuantityBadge: View {
    var count: Int
    
    @ScaledMetric(relativeTo: .caption) private var scale = 1.0
    private let metrics = BirdFoodStoreMetrics.Card.card
    
    var body: some View {
        Text(count.formatted())
            .foregroundStyle(.white)
            .fontWeight(.semibold)
            .fontDesign(.rounded)
            .padding(.vertical, 2 * scale)
            .padding(.horizontal, 4 * scale)
            .frame(minWidth: metrics.badgeQuantityMinWidth * scale)
            .background(.premiumBirdFood, in: .capsule)
    }
}

#Preview {
    BirdFoodQuantityBadge(count: 5)
}
