//
//  Account.swift
//  BackyardBirdies
//
//  Created by Patrick Charlson on 4/8/2025.
//

import Foundation
import SwiftData

@Model public class Account {
    
    @Attribute(.unique) public var id: String
    public var bird: Bird?
    public var joinDate: Date
    public var displayName: String
    public var emailAddress: String
    public var isPremiumMember: Bool
    
    public init(joinDate: Date, displayName: String, emailAddress: String, isPremiumMember: Bool) {
        self.id = UUID().uuidString
        self.joinDate = joinDate
        self.displayName = displayName
        self.emailAddress = emailAddress
        self.isPremiumMember = isPremiumMember
        
    }
}
