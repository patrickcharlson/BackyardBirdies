//
//  NewBirdIndicator.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 13/07/2025.
//

import SwiftUI

struct NewBirdIndicator: View {
    
    enum IndicatorPhase: CaseIterable {
        case idle
        case scale
    }
    var body: some View {
        PhaseAnimator(IndicatorPhase.allCases) { phase in
            Image(systemName: "bird.fill")
                .scaleEffect(phase == .scale ? 1.2 : 1)
                .rotationEffect(phase == .scale ? .degrees(-10): .zero)
                .padding(8)
                .background(in: .circle)
                .backgroundStyle(.teal.gradient.opacity(phase == .scale ? 1.0 : 0.5))
                .scaleEffect(phase == .scale ? 1.05: 1.0)
        }
    }
}

#Preview {
    NewBirdIndicator()
        .font(.system(size: 30))
        .scaleEffect(4.0)
}
