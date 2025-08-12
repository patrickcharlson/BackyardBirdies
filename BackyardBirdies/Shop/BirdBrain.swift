//
//  BirdBrain.swift
//  BackyardBirdies
//
//  Created by Patrick Charlson on 11/8/2025.
//

import Foundation
import OSLog
import SwiftData
import StoreKit

@ModelActor
actor BirdBrain {
    private let logger = Logger(subsystem: "BackyardBirds", category: "BirdBrain")
    
    private var updatesTask: Task<Void, Never>?
    
    private(set) static var shared: BirdBrain!
    
    static func createSharedInstance(modelContext: ModelContext) {
        shared = BirdBrain(modelContainer: modelContext.container)
    }
    
    func process(transaction verificationResult: VerificationResult<Transaction>) async {
        do {
            let unsafeTransaction = verificationResult.unsafePayloadValue
            logger.log("""
            Processing transaction ID \(unsafeTransaction.id) for \
            \(unsafeTransaction.productID)
            """)
        }
        
        let transaction: Transaction
        switch verificationResult {
        case .verified(let t):
            logger.debug("""
            Transaction ID \(t.id) for \(t.productID) is verified
            """)
            transaction = t
        case .unverified(let t, let error):
            logger.error("""
            Transaction ID \(t.id) for \(t.productID) is unverified: \(error)
            """)
            return
        }
        
        if case .consumable = transaction.productType {
            guard let (birdFood, product) = birdFood(for: transaction.productID) else {
                logger.fault("""
                Attempting to grant access to \(transaction.productID) for \
                transaction ID \(transaction.id) but failed to query for
                corresponding bird food model.
                """)
                return
            }
            
            let delta = product.quantity * transaction.purchasedQuantity
            
            if transaction.revocationDate == nil, transaction.revocationReason == nil {
                birdFood.ownedQuantity += delta
                
                logger.log("""
                Added \(delta) \(birdFood.id)(s) from transaction ID \
                \(transaction.id). New total quantity: \(birdFood.ownedQuantity)
                """)
                
                await transaction.finish()
                
                logger.debug("""
                Finished transaction ID \(transaction.id) for \
                \(transaction.productID)
                """)
            } else {
                birdFood.ownedQuantity -= delta
                
                logger.log("""
                Removed \(delta) \(birdFood.id)(s) because transaction ID \
                \(transaction.id) was revoked due to \
                \(transaction.revocationReason?.localizedDescription ?? "unknown"). \
                New total quantity: \(birdFood.ownedQuantity).
                """)
            }
        } else {
            await transaction.finish()
        }
        
        do {
            try modelContext.save()
        } catch {
            logger.error("Could not save model context: \(error.localizedDescription)")
        }
    }
    
    func status(for statuses: [Product.SubscriptionInfo.Status], ids: PassIdentifiers) -> PassStatus {
        let effectiveness = statuses.max { lhs, rhs in
            let lhsStatus = PassStatus(
                productID: lhs.transaction.unsafePayloadValue.productID,
                ids: ids
            ) ?? .notSubscribed
            let rhsStatus = PassStatus(
                productID: rhs.transaction.unsafePayloadValue.productID,
                ids: ids
            ) ?? .notSubscribed
            return lhsStatus < rhsStatus
        }
        
        guard let effectiveness else {
            return .notSubscribed
        }
        
        let transaction: Transaction
        switch effectiveness.transaction {
        case .verified(let t):
            logger.debug("""
            Transaction ID \(t.id) for \(t.productID) is verified
            """)
            transaction = t
        case .unverified(let t, let error):
            logger.error("""
            Transaction ID \(t.id) for \(t.productID) is unverified: \(error)
            """)
            return .notSubscribed
            
        }
        return PassStatus(productID: transaction.productID, ids: ids) ?? .notSubscribed
    }
    
    func checkForUnfinishedTransactions() async {
        logger.debug("Checking for unfinished transactions")
        for await transaction in Transaction.unfinished {
            let unsafeTransaction = transaction.unsafePayloadValue
            logger.log("""
                Processing unfinished transaction ID \(unsafeTransaction.id) for \
                \(unsafeTransaction.productID)
                """)
            Task.detached(priority: .background) {
                await self.process(transaction: transaction)
            }
        }
        logger.debug("Finished checking for unfinished transactions")
        
    }
    
    func observeTransactionUpdates() {
        self.updatesTask = Task { [weak self] in
            self?.logger.debug("Observing transaction updates")
            for await update in Transaction.updates {
                guard let self else { break }
                await self.process(transaction: update)
            }
        }
    }
    
    private func birdFood(for productID: Product.ID) -> (BirdFood, BirdFood.Product)? {
        try! modelContext.fetch(FetchDescriptor<BirdFood>()).birdFood(for: productID)
    }
}
