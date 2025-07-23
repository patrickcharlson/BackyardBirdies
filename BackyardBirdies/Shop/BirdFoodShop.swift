//
//  BirdFoodShop.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 21/07/2025.
//

import SwiftUI
import SwiftData
import StoreKit

struct BirdFoodShop: View {
    
    @Query(sort: [.init(\BirdFood.name, comparator: .localizedStandard)])
    private var allBirdFood: [BirdFood]
    
    var body: some View {
        shopContent
    }
    
    var shopContent: some View {
        ScrollView {
            VStack(spacing: 10) {
                if let (birdFood, product) = bestValue {
                    ProductView(id: product.id) {
                        BirdFoodProductIcon(birdFood: birdFood, quantity: product.quantity)
                            .bestBirdFoodValueBadge()
                    }
                    .padding(.vertical)
                    .background(.background.secondary, in: .rect(cornerRadius: 20))
                }
            }
        }
    }
    
    private var bestValue: (BirdFood, BirdFood.Product)? {
        allBirdFood
            .first { $0.id == "Nutrition Pellet" }
            .flatMap { nutritionPellet in
                nutritionPellet.products.max { lhs, rhs in
                    lhs.quantity < rhs.quantity
                }
                .map {
                    (nutritionPellet, $0)
                }
            }
    }
}

#Preview {
    NavigationStack {
        ZStack {
            BirdFoodShop()
        }
    }
    .backyardBirdsDataContainer(inMemory: true)
}
