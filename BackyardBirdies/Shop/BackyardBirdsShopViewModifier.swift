//
//  BackyardBirdsShopViewModifier.swift
//  BackyardBirdies
//
//  Created by Patrick Charlson on 3/8/2025.
//

import SwiftUI
import OSLog


private let logger = Logger(subsystem: "BackyardBirds", category: "BackyardBirdsShopViewModifier")

struct BackyardBirdsShopViewModifier: ViewModifier {
    @Environment(\.modelContext) private var modelContext
    
    func body(content: Content) -> some View {
        ZStack {
            content
        }
        .subscriptionPassStatusTask()
        .onAppear {
            logger.info("Creating BirdBrain shared instance")
            BirdBrain.createSharedInstance(modelContext: modelContext)
            logger.info("BirdBrain shared instance created")
        }
        .task {
            logger.info("Starting tasks to observe transaction updates")
            await BirdBrain.shared.observeTransactionUpdates()
            await BirdBrain.shared.checkForUnfinishedTransactions()
            logger.info("Finished observing transaction updates")
        }
    }
}

extension View {
    func backyardBirdsShop() -> some View {
        modifier(BackyardBirdsShopViewModifier())
    }
}
