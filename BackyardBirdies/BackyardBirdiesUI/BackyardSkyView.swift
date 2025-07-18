//
//  BackyardSkyView.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 19/07/2025.
//

import SwiftUI

struct BackyardSkyView: View {
    var timeInterval: TimeInterval
    
    public init(timeInterval: TimeInterval = 60 * 60 * 12) {
        self.timeInterval = timeInterval
    }
    
    var colorData: BackyardTimeOfDayColorData {
        BackyardTimeOfDayColorData.colorData(timeInterval: timeInterval)
    }
    var body: some View {
        LinearGradient(
            colors: [
                colorData.skyGradientStart.color,
                colorData.skyGradientEnd.color
            ],
            startPoint: .top,
            endPoint: .bottom
            )
    }
}
