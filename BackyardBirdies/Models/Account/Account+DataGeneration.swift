//
//  Account+DataGeneration.swift
//  BackyardBirdies
//
//  Created by Patrick Charlson on 4/8/2025.
//

import Foundation
import SwiftData
import OSLog

private let logger = Logger(subsystem: "BackyardBirdsData", category: "Account Generation")

extension Account {
    static func generateAccount(modelContext: ModelContext) {
        let bird = try! modelContext.fetch(FetchDescriptor<Bird>()).first!
        let date = Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 5, hour: 9, minute: 41))!
        
        let account = Account(
            joinDate: date,
            displayName: "Patrick Charlson",
            emailAddress: "patecharlson@icloud.com",
            isPremiumMember: true)
        modelContext.insert(account)
        account.bird = bird
        
        logger.info("Finished generating account")
    }
}
