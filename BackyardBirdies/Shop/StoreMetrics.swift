//
//  StoreMetrics.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 21/07/2025.
//

import SwiftUI

struct BirdFoodStoreMetrics {
    let card: Card
    let cardActionButton: CardActionButton
    let food: Food
    
    struct Card {
        let badgeQuantityMinWidth: CGFloat
        let controlSize: ControlSize
        let horizontalPadding: CGFloat
        let verticalPadding: CGFloat
        let verticalSpacing: CGFloat
        
        static let card = BirdFoodStoreMetrics.Card(
            badgeQuantityMinWidth: 25,
            controlSize: .large,
            horizontalPadding: 20,
            verticalPadding: 40,
            verticalSpacing: 24
        )
    }
    
    struct CardActionButton {
        let backgroundInset: CGFloat
        let horizontalSpacing: CGFloat
        let minWidth: CGFloat
        
        static let cardActionButton = BirdFoodStoreMetrics.CardActionButton(
            backgroundInset: -3,
            horizontalSpacing: 10,
            minWidth: 20
        )
    }
    
    struct Food {
        let imageHeight: CGFloat
        let imagePadding: CGFloat
        let imageQuantityBadgeFont: Font
        let imageWidth: CGFloat
        let nameFont: Font
        let summaryFont: Font
        
        static let food = BirdFoodStoreMetrics.Food(
            imageHeight: 100,
            imagePadding: 10,
            imageQuantityBadgeFont: .body,
            imageWidth: 100,
            nameFont: .title3.weight(.semibold),
            summaryFont: .callout
        )
    }
    
    static let birdFoodStore = BirdFoodStoreMetrics(
        card: BirdFoodStoreMetrics.Card.card,
        cardActionButton: BirdFoodStoreMetrics.CardActionButton.cardActionButton,
        food: BirdFoodStoreMetrics.Food.food)
}
