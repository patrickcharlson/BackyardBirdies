//
//  BackyardSupplies.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 12/07/2025.
//

import Foundation

private let timeIntervalUntilFoodLow = TimeInterval(hours: 8)
private let timeIntervalUntilWaterLow = TimeInterval(hours: 15)
private let timeIntervalUntilFoodEmpty = timeIntervalUntilFoodLow + TimeInterval(hours: 1)
private let timeIntervalUntilWaterEmpty = timeIntervalUntilWaterLow + TimeInterval(hours: 1)

public enum BackyardSupplies: CaseIterable {
    case food
    case water
    
    public var durationUntilLow: TimeInterval {
        switch self {
        case .food:
            timeIntervalUntilFoodLow
        case .water:
            timeIntervalUntilWaterLow
        }
    }
    
    public var totalDuration: TimeInterval {
        switch self {
        case .food:
            timeIntervalUntilFoodEmpty
        case .water:
            timeIntervalUntilWaterEmpty
        }
    }
}
