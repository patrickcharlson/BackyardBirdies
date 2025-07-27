//
//  BirdGridItem.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 22/07/2025.
//

import SwiftUI

struct BirdGridItem: View {
    var bird: Bird
    
    var body: some View {
        VStack {
            BirdIcon(bird: bird, insets: 10)
                .padding(.horizontal, 10)
            
            VStack {
                Text(bird.speciesName)
                    .font(.callout)
                Text(bird.visitStatus.title)
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    ModelPreview { bird in
        BirdGridItem(bird: bird)
    }
}
