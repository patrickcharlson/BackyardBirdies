//
//  FloorArtwork.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 18/07/2025.
//

import SwiftUI

private let variants = [
    ImageResource.floor1, .floor2, .floor3, .floor4
]

struct FloorArtwork: View {
    var variantIndex: Int
    
    public init(variant: Int) {
        self.variantIndex = variant
    }
    var body: some View {
        Image(variants[variantIndex])
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
