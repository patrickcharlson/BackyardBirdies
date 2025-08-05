//
//  BackyardBirdsShopViewModifier.swift
//  BackyardBirdies
//
//  Created by Patrick Charlson on 3/8/2025.
//

import Foundation
import SwiftUI

struct BackyardBirdsShopViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        ZStack {
            content
        }
        .subscriptionPassStatusTask()
    }
}

extension View {
    func backyardBirdsShop() -> some View {
        modifier(BackyardBirdsShopViewModifier())
    }
}
