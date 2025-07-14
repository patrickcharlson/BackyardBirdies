//
//  AppScreen.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 12/07/2025.
//

import SwiftUI

enum AppScreen: Identifiable, CaseIterable {
    case backyards
    case birds
    case plants
    case account
    
    var id: AppScreen {self}
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .backyards:
            Label {
                Text("Backyards")
            } icon: {
                Image(.fountain)
            }
        case .birds:
            Label("Birds", systemImage: "bird")
        case .plants:
            Label("Plants", systemImage: "leaf")
        case .account:
            Label("Account", systemImage: "person.crop.circle")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .backyards:
            BackyardsScreen()
        case .birds:
            BirdsScreen()
        case .plants:
            PlantsScreen()
        case .account:
            AccountScreen()
        }
    }
}
