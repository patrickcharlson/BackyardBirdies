//
//  AppDetailColumn.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 12/07/2025.
//

import SwiftUI

struct AppDetailColumn: View {
    var screen: AppScreen?
    
    var body: some View {
        Group {
            if let screen {
                screen.destination
            } else {
                ContentUnavailableView("Select a Backyard", systemImage: "bird", description: Text("Pick something from the list."))
            }
        }
    }
}

#Preview {
    AppDetailColumn()
}
