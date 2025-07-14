//
//  BackyardGridItem.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 13/07/2025.
//

import SwiftUI

struct BackyardGridItem: View {
    var backyard: Backyard
    
    var body: some View {
        ZStack {
            NavigationLink(value: backyard.id) {
                BackyardViewport(backyard: backyard)
            }
        }
    }
}

#Preview {
    ModelPreview { backyard in
        BackyardGridItem(backyard: backyard)
    }
}
