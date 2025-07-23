//
//  BirdFoodProductIcon.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 21/07/2025.
//

import SwiftUI
import SwiftData
import StoreKit

struct BirdFoodProductIcon: View {
    var birdFood: BirdFood
    var quantity: Int
    
    var body: some View {
        image
            .scaledToFit()
            .padding(birdFood.id == "Nectar" && quantity > 1 ? 18 : 10)
            .background(.fill.tertiary, in: .circle)
    }
    
    var image: Image {
        switch quantity {
        case 1: birdFood.image
        default: birdFood.alternateImage
        }
    }
}

#Preview {
    ModelPreview { birdFood in
        BirdFoodProductIcon(birdFood: birdFood, quantity: 1)
    }
}
