//
//  BackyardVisitorEvent.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 13/07/2025.
//

import Foundation
import SwiftData

@Model
public class BackyardVisitorEvent {
    @Attribute(.unique) public var id: String
    public var backyard: Backyard?
    public var bird: Bird?
    public var startDate: Date
    public var endDate: Date
    public var duration: TimeInterval
    
    public var dateRange: Range<Date> {
        startDate ..< endDate
    }
    
    public init(id: UUID = UUID(), startDate: Date, duration: TimeInterval) {
        self.id = id.uuidString
        self.startDate = startDate
        self.duration = duration
        self.endDate = startDate.addingTimeInterval(duration)
        
    }
}
