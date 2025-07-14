//
//  ContentView.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 12/07/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selection: AppScreen? = .backyards
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    var body: some View {
        if prefersTabNavigation {
            AppTabView(selection: $selection)
        } else {
            NavigationSplitView {
                AppSidebarList(selection: $selection)
            } detail: {
                AppDetailColumn(screen: selection)
            }
        }
    }
}

#Preview {
    ContentView()
//        .backyardBirdsDataContainer(inMemory: true)
}
