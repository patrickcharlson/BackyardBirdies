//
//  ColorData.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 16/07/2025.
//

import SwiftUI

public struct ColorData: Codable {
    public var hue: Double
    public var saturation: Double
    public var brightness: Double
    
    // •    hue: the base color (range 0–1, where 0 = red, 0.33 = green, 0.66 = blue, etc.)
    // •    saturation: the intensity of the color (0 = grayscale, 1 = full color)
    // •    brightness: how bright the color is (0 = black, 1 = full brightness)
    
    public init(hue: Double, saturation: Double, brightness: Double) {
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
    }
    
    public var color: Color {
        Color(hue: hue, saturation: saturation, brightness: brightness)
    }
    
    public static var white: ColorData { .init(hue: 0, saturation: 0, brightness: 1) }
    
    public func interpolate(to other: ColorData, percent: Double, clamped: Bool = true) -> ColorData {
        ColorData(
            hue: Angle.degrees(hue * 360).interpolate(to: Angle.degrees(other.hue * 360), percent: percent).degrees / 360,
            saturation: saturation.interpolate(to: other.saturation, percent: percent, clamped: clamped),
            brightness: brightness.interpolate(to: other.brightness, percent: percent, clamped: clamped)
            
        )
    }
}
