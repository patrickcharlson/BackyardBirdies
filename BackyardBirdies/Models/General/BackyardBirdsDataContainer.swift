//
//  BackyardBirdsDataContainer.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 12/07/2025.
//

import SwiftUI
import SwiftData

struct BackyardBirdsDataContainer: ViewModifier {
    let container: ModelContainer
    
    init(inMemory: Bool) {
        container = try! ModelContainer(for: DataGeneration.schema, configurations: [ModelConfiguration(isStoredInMemoryOnly: inMemory)])
    }
    
    func body(content: Content) -> some View {
        content
            .generateData()
            .modelContainer(container)
    }
}

struct GenerateDataModifier: ViewModifier {
    @Environment(\.modelContext) private var modelContext
    
    func body(content: Content) -> some View {
        content.onAppear {
            DataGeneration.generateAllData(modelContext: modelContext)
        }
    }
}


public extension View {
    func backyardBirdsDataContainer(inMemory: Bool = DataGenerationOptions.inMemoryPersistence) -> some View {
        modifier(BackyardBirdsDataContainer(inMemory: inMemory))
    }
}

fileprivate extension View {
    func generateData() -> some View {
        modifier(GenerateDataModifier())
    }
}
