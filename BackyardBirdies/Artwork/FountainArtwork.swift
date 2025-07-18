//
//  FountainArtwork.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 18/07/2025.
//

import SwiftUI
private let variants = [
    ImageResource.Fountain.terracotta, .Fountain.stone, .Fountain.marble
]

struct FountainArtwork: View {
    var variantIndex: Int
    
    public init(variant: Int) {
        self.variantIndex = variant
    }
    var body: some View {
        Image(variants[variantIndex])
            .resizable()
            .scaledToFit()
        
    }
}
