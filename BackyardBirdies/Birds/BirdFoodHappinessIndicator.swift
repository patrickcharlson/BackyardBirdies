//
//  BirdFoodHappinessIndicator.swift
//  BackyardBirdies
//
//  Created by Patrick Charlson on 10/8/2025.
//

import SwiftUI

struct BirdFoodHappinessIndicator: View {
    var birdName: String
    var foodName: String
    
    @State private var showingHeart: Bool = false
    @State private var showingCallout: Bool = false
    @ScaledMetric private var indicatorHeight: CGFloat = 80.0
    
    var body: some View {
        HStack(spacing: 10) {
            if showingHeart {
                Image(systemName: "heart.fill")
                    .foregroundStyle(.linearGradient(colors: [.pink, .red], startPoint: .top, endPoint: .bottom))
                    .font(.title)
                    .padding(8)
                    .background(.red.gradient.opacity(0.25), in: .circle)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 5)
                    .transition(.scale(scale: 0.25).combined(with: .opacity))
            }
            
            if showingCallout {
                Text("The \(birdName) loved the \(foodName)!",
                     comment: "First variable is the name of a bird. Second variable is a type of bird food")
                .foregroundStyle(.secondary)
                .font(.callout)
                .transition(.scale(0.5).combined(with: .opacity))
                .fixedSize(horizontal: false, vertical: true)
            }
        }
        .clipShape(.capsule)
        .background(.regularMaterial.shadow(.drop(color: .black.opacity(0.15), radius: 20, y: 10)), in: .capsule)
        .padding()
        .frame(height: indicatorHeight)
        .task {
            Task {
                withAnimation(.spring(duration: 0.5, bounce: 0.5)) {
                    showingHeart = true
                }
                try await Task.sleep(for: .seconds(2))
                withAnimation {
                    showingCallout = true
                }
                try await Task.sleep(for: .seconds(4))
                withAnimation {
                    showingCallout = false
                }
                try await Task.sleep(for: .seconds(1))
                withAnimation {
                    showingHeart = false
                }
            }
        }
    }
}

#Preview {
    _IndicatorPreview()
}

private struct _IndicatorPreview: View {
    @State private var id = 0
    
    var body: some View {
        VStack {
            Spacer()
            BirdFoodHappinessIndicator(birdName: "Hummingbird", foodName: "Nutritional Pellet")
                .id(id)
            Spacer()
            Button {
                id += 1
            } label: {
                Text(verbatim: "Restart")
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.fill)
    }
}
