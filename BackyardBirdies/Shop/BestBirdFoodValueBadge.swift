//
//  BestBirdFoodValueBadge.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 21/07/2025.
//

import SwiftUI

private struct BestBirdFoodValueBadge: View {
    
    var body: some View {
        Text("Best Value \(Image(systemName: "sparkles"))", comment: "Bird food label with sparkles icon.")
            .padding(.vertical, 5)
            .padding(.horizontal)
            .background(.regularMaterial, in: .capsule)
            .overlay {
                Capsule().strokeBorder()
            }
            .foregroundStyle(.premiumBirdFood)
            .dynamicTypeSize(...(.xLarge))
            .fixedSize()
            .offset(y: 10.0)
            
            
    }
}

extension View {
    func bestBirdFoodValueBadge() -> some View {
        overlay(alignment: .bottom) {
            BestBirdFoodValueBadge()
        }
    }
}

#Preview {
    BestBirdFoodValueBadge()
}
