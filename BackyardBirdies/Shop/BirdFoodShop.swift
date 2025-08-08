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
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        shopContent
            .background(.background.secondary)
            .navigationTitle("Bird Food Shop")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Done", systemImage: "xmark")
                    }
                    .labelStyle(.iconOnly)
                }
            }
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
                    .productViewStyle(.large)
                    .padding()
                    
                    Text("Other Bird Food")
                        .font(.title3.weight(.medium))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                }
                
                ForEach(premiumBirdFood) { birdFood in
                    BirdFoodShopShelf(title: birdFood.name) {
                        ForEach(birdFood.orderedProducts) { product in
                            ProductView(id: product.id) {
                                BirdFoodProductIcon(birdFood: birdFood, quantity: product.quantity)
                            }
                        }
                    }
                }
            }
            .scrollClipDisabled()
        }
        .contentMargins(.horizontal, 20, for: .scrollContent)
        .scrollIndicators(.hidden)
    }
    
    private var premiumBirdFood: [BirdFood] {
        allBirdFood
            .filter(\.isPremium)
            .sorted { lhs, rhs in
                lhs.priority > rhs.priority}
        
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
