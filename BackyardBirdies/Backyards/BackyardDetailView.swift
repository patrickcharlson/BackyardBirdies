//
//  BackyardDetailView.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 20/07/2025.
//

import SwiftUI
import SwiftData

struct BackyardDetailView: View {
    var backyard: Backyard
    
    var body: some View {
        ScrollView {
            BackyardViewport(backyard: backyard)
                .containerShape(.rect(cornerRadius: 20))
            
            LazyVGrid(columns: [.init(.adaptive(minimum: 400))]) {
                BackyardSupplyIndicator(backyard: backyard, supplies: .food)
                BackyardSupplyIndicator(backyard: backyard, supplies: .water)
            }
            
            Text("Recent Visitors")
                .font(.subheadline.bold())
                .foregroundStyle(.tertiary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            
            LazyVStack {
                RecentBackyardVisitorsView(backyard: backyard)
            }
        }
        .contentMargins(20, for: .scrollContent)
        .navigationTitle(backyard.name)
        .toolbar {
            ToolbarItem {
                Button {
                    backyard.isFavorite.toggle()
                } label : {
                    Label("Favorite", systemImage: "star")
                        .symbolVariant(backyard.isFavorite ? .fill : .none)
                        .sensoryFeedback(.success, trigger: backyard.isFavorite)
                }
            }
        }
    }
    
}

#Preview {
    ModelPreview { backyard in
        NavigationStack {
            BackyardDetailView(backyard: backyard)
        }
    }
}
