//
//  PrefersTabNavigationEnvironmentKey.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 12/07/2025.
//

import SwiftUI

struct PrefersTabNavigationEnvironmentKey: EnvironmentKey {
    static var defaultValue: Bool = true
}

extension EnvironmentValues {
     var prefersTabNavigation: Bool {
         get {self[PrefersTabNavigationEnvironmentKey.self]}
         set {self[PrefersTabNavigationEnvironmentKey.self] = newValue }
    }
}
