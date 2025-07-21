//
//  BirdFoodPickerSheet.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 21/07/2025.
//

import SwiftUI
import SwiftData

struct BirdFoodPickerSheet: View {
    var backyard: Backyard
    
    @Query(sort: [.init(\BirdFood.priority, order: .reverse), .init(\BirdFood.name, comparator: .localizedStandard)])
    private var birdFood: [BirdFood]

    @State private var presentingBirdFoodShop = false
    @Environment(\.dismiss) private var dismiss
    
    private let metrics = BirdFoodStoreMetrics.birdFoodStore
    
    var premiumFood: [BirdFood] {
        birdFood.filter(\.isPremium)
    }
    
    var body: some View {
        GeometryReader { geometry in
            let cardWidth: CGFloat? = geometry.size.width > 0 ? (min(geometry.size.width * 0.7, 240) - 40): nil
            
            NavigationStack {
                ScrollView {
                    premiumText
                    birdFoodShopLink
                    
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 10) {
                            ForEach(premiumFood) { food in
                                BirdFoodCard(
                                    backyard: backyard,
                                    food: food,
                                    presentingBirdShop: .constant(false)
                                )
                                .frame(width: cardWidth)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollClipDisabled()
                    .scrollIndicators(.hidden)
                }
                .navigationTitle("Bird Food")
                .contentMargins([.top, .horizontal], 20, for: .scrollContent)
                .contentMargins(.bottom, 40, for: .scrollContent)
                .navigationDestination(isPresented: $presentingBirdFoodShop) {
                    BirdFoodShop()
                }
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        doneButton
                    }
                }
            }
        }
    }
    
    func sectionHeader(_ text: LocalizedStringKey, comment: StaticString) -> some View {
        Text(text, comment: comment)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.subheadline.bold())
            .foregroundStyle(.tertiary)
    }
    
    var doneButton: some View {
        Button("Done", action: dismiss.callAsFunction)
    }
    
    var premiumText: some View {
        sectionHeader("Premium", comment: "Refers to a premium bird food item versus standard bird food item.")
    }
    
    var birdFoodShopLink: some View {
        Button {
            presentingBirdFoodShop = true
        } label : {
            HStack(spacing: 12) {
                Label("Bird Food Shop", systemImage: "storefront")
                Image(systemName: "chevron.forward")
                    .imageScale(.medium)
                    .fontWeight(.semibold)
                    .foregroundStyle(.tertiary)
            }
            .imageScale(.large)
            .controlSize(metrics.card.controlSize)
        }
        .tint(.premiumBirdFood)
        .buttonStyle(.bordered)
        .controlSize(.large)
    }
    
    struct BirdFoodCard: View {
        var backyard: Backyard
        var food: BirdFood
        
        @Binding var presentingBirdShop: Bool
        @Environment(\.dismiss) private var dismiss
        
        private let metrics = BirdFoodStoreMetrics.birdFoodStore
        
        var needsMore: Bool {
            food.isPremium && food.ownedQuantity <= 0
        }
        
        var body: some View {
            VStack(spacing: metrics.card.verticalSpacing) {
                food.image
                    .scaledToFit()
                    .padding(metrics.food.imagePadding)
                    .frame(width: metrics.food.imageWidth, height: metrics.food.imageHeight)
                    .background(.fill.tertiary, in: .circle)
                    .overlay(alignment: .bottomTrailing) {
                        if food.isPremium {
                            BirdFoodQuantityBadge(count: food.ownedQuantity)
                                .font(metrics.food.imageQuantityBadgeFont)
                        }
                    }
                VStack {
                    Text(food.name)
                        .font(metrics.food.nameFont)
                    
                    Text(food.summary)
                        .foregroundStyle(.secondary)
                        .font(metrics.food.summaryFont)
                }
                .multilineTextAlignment(.center)
                
                Button {
                    if needsMore {
                        presentingBirdShop = true
                    } else {
                        withAnimation(.default.delay(0.35)) {
                            backyard.birdFood = food
                            backyard.foodRefillDate = .now
                        }
                        dismiss()
                    }
                } label: {
                    if needsMore {
                        Text("Shop", comment: "Label on button that leads to Bird Food Shop.")
                    } else if food.isPremium {
                        HStack(spacing: metrics.cardActionButton.horizontalSpacing) {
                            Text("Use", comment: "Refers to Premium Food.")
                        }
                    } else {
                        Text("Choose", comment: "Refers to Standard Food")
                    }
                }
                .controlSize(metrics.card.controlSize)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .tint(food.isPremium ? .premiumBirdFood : nil)
            }
            .padding(.horizontal, metrics.card.horizontalPadding)
            .padding(.vertical, metrics.card.verticalPadding)
        }
    }
}

#Preview {
    ModelPreview { backyard in
        BirdFoodPickerSheet(backyard: backyard)
    }
}
