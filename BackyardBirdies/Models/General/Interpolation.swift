//
//  Interpolation.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 16/07/2025.
//

import SwiftUI

public extension BinaryFloatingPoint {
    func interpolate(to destination: Self, percent: Self, clamped: Bool = true) -> Self {
        let percent = clamped ? min(max(percent, 0), 1) : percent
        return (1 - percent) * self + percent * destination
    }
}

extension Angle {
    func interpolate(to destination: Angle, percent: Double) -> Angle {
        let max = Double.pi * 2
        let deltaAngle = (destination.radians - self.radians).truncatingRemainder(dividingBy: max)
        let distance = (2 * deltaAngle).truncatingRemainder(dividingBy: max) - deltaAngle
        return Angle.radians(self.radians + distance * percent)
    }
}
