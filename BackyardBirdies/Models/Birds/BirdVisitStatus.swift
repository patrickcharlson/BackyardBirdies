//
//  BirdVisitStatus.swift
//  BackyardBirdies
//
//  Created by Patrick Charlson on 27/7/2025.
//

import Foundation


public enum BirdVisitStatus {
    case never
    case recently(Date)
}

public extension BirdVisitStatus {
    var title: String {
        switch self {
        case .never:
            return String(localized: "Not yet seen",
                          table: "Birds",
                          comment: "A Phrase used to indicate that a bird has not never visited a backyard"
            )
        case .recently(let date):
            return String(
                localized: "Seen \(date.formatted(.relative(presentation: .numeric, unitsStyle: .narrow)))",
                table: "Birds",
                comment: "The variable is a shorthand formatted duration. For example, 4d, 30m, or 20s ago."
            )
        }
    }
}
