//
//  RestorePurchasesButton.swift
//  BackyardBirdies
//
//  Created by Patrick Charlson on 4/8/2025.
//

import SwiftUI
import StoreKit


struct RestorePurchasesButton: View {
    @State private var isRestoring = false
    
    var body: some View {
        Button("Restore Purchases") {
            isRestoring = true
            Task {
                defer { isRestoring = false }
                try await AppStore.sync()
            }
        }
        .disabled(isRestoring)
    }
}

#Preview {
    RestorePurchasesButton()
}
