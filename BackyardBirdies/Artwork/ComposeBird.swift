//
//  ComposeBird.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 22/07/2025.
//

import SwiftUI

struct ComposeBird: View {
    var bird: Bird
    var direction: HorizontalEdge
    
    public init(bird: Bird, direction: HorizontalEdge = .leading) {
        self.bird = bird
        self.direction = direction
    }
    
    var body: some View {
        ZStack {
            if let species = bird.species {
                ForEach(species.parts) { part in
                    if part.flipbookFrameCount != nil {
                        let i = 0
                        Image("\(species.id)/\(part.name)\(i + 1)")
                            .resizable()
                            .scaledToFit()
                            .colorMultiply(bird.colors.colorData(for: part.colorStyle).color)
                    } else {
                        Image("\(species.id)/\(part.name)")
                            .resizable()
                            .scaledToFit()
                            .colorMultiply(bird.colors.colorData(for: part.colorStyle).color)
                    }
                }
            }
        }
        .scaleEffect(x: direction == .trailing ? -1 : 1)
        .flipsForRightToLeftLayoutDirection(true)
        .id(bird.id)
    }
}

#Preview {
    ModelPreview { bird in
        ComposeBird(bird: bird)
    }
}
