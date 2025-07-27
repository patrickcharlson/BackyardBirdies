//
//  BirdIcon.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 22/07/2025.
//

import SwiftUI
import SwiftData

struct BirdIcon: View {
    var bird: Bird
    var insets: Double
    var direction: HorizontalEdge
    
    public init(bird: Bird, insets: Double? = nil, direction: HorizontalEdge = .leading) {
        self.bird = bird
        self.insets = insets ?? 6
        self.direction = direction
    }
    
    var body: some View {
        ComposeBird(bird: bird, direction: direction)
            .padding(insets)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                BackyardSkyView(timeInterval: bird.backgroundTimeInterval)
                    .opacity(0.8)
                    .clipShape(.containerRelative)
            }
//            .background(.fill.tertiary)
            .overlay {
                ContainerRelativeShape().strokeBorder(.tertiary)
            }
            .containerShape(.circle)
            .compositingGroup()
        
    }
    
}

#Preview {
    ModelPreview { bird in
        BirdIcon(bird: bird)
    }
}
