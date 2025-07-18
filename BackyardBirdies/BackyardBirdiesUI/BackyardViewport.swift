//
//  BackyardViewport.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 13/07/2025.
//

import SwiftUI


struct BirdAnimation {
    var offset: CGSize = .zero
    var scale: Double = 1
    var rotation: Angle = .zero
    var flip: Bool = false
}

struct BackyardViewport: View {
    var backyard: Backyard
    
    @State private var birdAnimation = BirdAnimation()
    
    public init(backyard: Backyard) {
        self.backyard = backyard
    }
    
    struct PlantPlacement: Hashable, Identifiable {
        var id: Self { self }
        var leading: Bool
        var index: Int
    }
    
    var leadingPlantPlacements: [PlantPlacement] {
        backyard.leadingPlants.indices.map {
            PlantPlacement(leading: true, index: $0)
        }
    }
    
    var trailingPlantPlacements: [PlantPlacement] {
        backyard.trailingPants.indices.map {
            PlantPlacement(leading: false, index: $0)
        }
    }
    
    var bird: Bird? {
        backyard.currentVisitorEvent?.bird
    }
    
    var body: some View {
        BackyardViewportLayout(birdNaturalScale: bird?.species?.naturalScale ?? 1) {
            HStack {
                SilhouetteArtwork(variant: backyard.leadingSilhoutteVariant)
                                  .colorMultiply(backyard.colorData.silhouette.color)
                                  .scaleEffect(x: -1)
                
                Spacer()
                
                SilhouetteArtwork(variant: backyard.trailingSilhoutteVariant)
                    .colorMultiply(backyard.colorData.silhouette.color)
            }
            .backyardViewportContent(.silhouette)
            
            FloorArtwork(variant: backyard.floorVariant)
                .backyardViewportContent(.floor)
            
            ForEach(leadingPlantPlacements) { placement in
                PlantView(plant: backyard.leadingPlants[placement.index], index: placement.index)
                    .backyardViewportContent(.plant(.leading))
            }
            
            FountainArtwork(variant: backyard.fountainVariant)
                .backyardViewportContent(.fountain)
                .zIndex(5)
            
            ForEach(trailingPlantPlacements) { placement in
                PlantView(plant: backyard.trailingPants[placement.index], index: placement.index)
                    .backyardViewportContent(.plant(.trailing))
            }
        }
        .flipsForRightToLeftLayoutDirection(true)
        .colorMultiply(backyard.colorData.atmosphereTint.color)
        .background {
            BackyardSkyView(timeInterval: backyard.timeIntervalOffset)
        }
        .overlay {
            ContainerRelativeShape()
                .strokeBorder(.separator, lineWidth: 0.1)
        }
        .clipShape(.containerRelative)
        .compositingGroup()
        .task {
            guard backyard.needsToPresentVisitor else { return }
            Task {
                birdAnimation = .init(offset: CGSize(width: 500, height: -100), scale: 0.1, rotation: .degrees(15))
                try await Task.sleep(for: .seconds(0.25))
                withAnimation(.spring(duration: 2, bounce: 0.25)) {
                    birdAnimation = .init(offset: CGSize(width: 50, height: -10), scale: 1.5, rotation: .degrees(-25))
                }
//                try await Task.sleep(for: .seconds(2))
//                withAnimation(.spring(duration: 2, bounce: 0.5)) {
//                    birdAnimation = .init(offset: CGSize(width: -100, height: 0), scale: 1.2, rotation: .degrees(0))
//                }
//                try await Task.sleep(for: .seconds(2))
//                withAnimation(.spring(duration: 0.25, bounce: 0)) {
//                    birdAnimation.flip = true
//                }
//                try await Task.sleep(for: .seconds(0.1))
//                withAnimation(.spring(duration: 2, bounce: 0.5)) {
//                    birdAnimation = .init(offset: CGSize(width: 40, height: -10), scale: 0.9, rotation: .degrees(4), flip: true)
//                }
//                try await Task.sleep(for: .seconds(2))
//                withAnimation(.spring(duration: 0.25, bounce: 0)) {
//                    birdAnimation.flip = false
//                }
//                try await Task.sleep(for: .seconds(0.1))
//                withAnimation(.spring(duration: 2, bounce: 0.5)) {
//                    birdAnimation = .init(offset: CGSize(width: 10, height: 0), scale: 1, rotation: .degrees(0))
//                }
            }
        }
    }
}

private struct BackyardViewportContentModifier: ViewModifier {
    var value: BackyardViewportContent
    
    func body(content: Content) -> some View {
        content.layoutValue(key: BackyardViewportContentKey.self, value: value)
    }
}


fileprivate extension View {
    func backyardViewportContent(_ value: BackyardViewportContent) -> some View {
        modifier(BackyardViewportContentModifier(value: value))
    }
}
