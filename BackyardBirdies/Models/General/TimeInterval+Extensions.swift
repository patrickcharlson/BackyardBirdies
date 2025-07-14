//
//  TimeInterval+Extensions.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 13/07/2025.
//

import Foundation

public extension TimeInterval {
    init(days: Double = 0, hours: Double = 0, minutes: Double = 0, seconds: Double = 0) {
        self = (24 * 60 * 60 * days) + (60 * 60 * hours) + (60 * minutes) + seconds
    }
}
