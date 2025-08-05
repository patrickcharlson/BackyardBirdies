//
//  PassIdentifiers.swift
//  BackyardBirdies
//
//  Created by Patrick Charlson on 3/8/2025.
//

import Foundation
import SwiftUI

public struct PassIdentifiers: Sendable {
    public var group: String
    
    public var individual: String
    public var family: String
    public var premium: String
}

public extension EnvironmentValues {
    
    private enum PassIDsKey: EnvironmentKey  {
        static var defaultValue = PassIdentifiers(
            group: "7004C0B1",
            individual: "pass.individual",
            family: "pass.family",
            premium: "pass.premium"
        )
    }
    
    var passIDs: PassIdentifiers {
        get { self[PassIDsKey.self]}
        set { self[PassIDsKey.self] = newValue }
    }
}
