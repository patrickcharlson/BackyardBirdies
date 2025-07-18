//
//  BackyardTimeOfDayColorData.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 16/07/2025.
//

import Foundation
import SwiftUI

public struct BackyardTimeOfDayColorData {
    public var skyGradientStart: ColorData
    public var skyGradientEnd: ColorData
    public var silhouette: ColorData
    public var atmosphereTint: ColorData
    
    public func interpolate(to other: BackyardTimeOfDayColorData, percent: Double, clamped: Bool = true) -> BackyardTimeOfDayColorData {
        BackyardTimeOfDayColorData(
            skyGradientStart: skyGradientStart.interpolate(to: other.skyGradientStart, percent: percent, clamped: clamped),
            skyGradientEnd: skyGradientEnd.interpolate(to: other.skyGradientEnd, percent: percent, clamped: clamped),
            silhouette: silhouette.interpolate(to: other.silhouette, percent: percent, clamped: clamped),
            atmosphereTint: atmosphereTint.interpolate(to: other.atmosphereTint, percent: percent, clamped: clamped)
        )
    }
    
    public static func colorData(timeInterval: TimeInterval) -> BackyardTimeOfDayColorData {
        let timeInterval = timeInterval.truncatingRemainder(dividingBy: TimeInterval(days: 1))
        let currentTimeOfDay = BackyardTimeOfDay(timeInterval: timeInterval)
        let nextTimeOfDay = BackyardTimeOfDay(timeInterval: timeInterval)
        let percent = timeInterval.truncatingRemainder(dividingBy: TimeInterval(hours: 1)) / TimeInterval(hours: 1)
        
        return currentTimeOfDay.colorData.interpolate(to: nextTimeOfDay.colorData, percent: percent)
        
    }
}
