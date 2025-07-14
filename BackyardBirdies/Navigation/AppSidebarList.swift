//
//  AppSidebarList.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 12/07/2025.
//

import SwiftUI

struct AppSidebarList: View {
    @Binding var selection: AppScreen?
    
    var body: some View {
        List(AppScreen.allCases, selection: $selection) { screen in
            NavigationLink(value: screen) {
                screen.label
            }
        }
        .navigationTitle("Backyard Birds")
    }
}

#Preview {
    NavigationSplitView {
        AppSidebarList(selection: .constant(.backyards))
    } detail: {
        Text(verbatim: "Check out that sidebar!")
    }
}
