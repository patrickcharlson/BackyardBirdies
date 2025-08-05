//
//  BackyardBirdsPassShop.swift
//  BackyardBirdies
//
//  Created by Patrick Charlson on 4/8/2025.
//

import SwiftUI
import StoreKit
import SwiftData

// 8:45 p.m. at night uses a great sky gradient.
private let skyTimeInterval = TimeInterval(hours: 20, minutes: 45)

struct BackyardBirdsPassShop: View {
    @Environment(\.passIDs.group) private var passGroupID
    @Environment(\.passStatus) private var passStatus
    
    private var showPremiumUpgrade: Bool {
        passStatus == .individual || passStatus == .family
    }
    
    var body: some View {
        SubscriptionStoreView(
            groupID: passGroupID,
            visibleRelationships: showPremiumUpgrade ? .upgrade : .all) {
                PassMarketingContent(showPremiumUpgrade: showPremiumUpgrade)
                    .containerBackground(for: .subscriptionStoreFullHeight) {
                        SkyBackground()
                    }
            }
            .storeButton(.visible, for: .redeemCode)
            .subscriptionStoreControlIcon { _, subscriptionInfo in
                Group {
                    switch PassStatus(levelOfService: subscriptionInfo.groupLevel) {
                    case .premium:
                        Image(systemName: "bird")
                    case .family:
                        Image(systemName: "person.3.sequence")
                    default:
                        Image(systemName: "wallet.pass")
                    }
                }
                .foregroundStyle(.accent)
                .symbolVariant(.fill)
            }
            .backgroundStyle(.clear)
            .subscriptionStoreButtonLabel(.multiline)
            .subscriptionStorePickerItemBackground(.thinMaterial)
    }
}

private let tagValue = BirdTag.premiumGoldHummingbird.rawValue

private struct PassMarketingContent: View {
    var showPremiumUpgrade: Bool = false
    
    @Query(filter: #Predicate<Bird> { $0.tag == tagValue })
    private var birds: [Bird]
    
    init(showPremiumUpgrade: Bool) {
        self.showPremiumUpgrade = showPremiumUpgrade
    }
    
    var body: some View {
        VStack(spacing: 10) {
            if let bird = birds.first {
                ComposeBird(bird: bird, direction: .trailing)
                    .frame(height: 100)
                    .padding(-10)
            }
            VStack(spacing: 3) {
                if showPremiumUpgrade {
                    subscriptionName
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .overlay(.bar, in: .capsule.stroke())
                }
                title
                    .font(.largeTitle.bold())
                    .foregroundStyle(.bar)
            }
            description
                .fixedSize(horizontal: false, vertical: true)
                .font(.title3.weight(.medium))
                .padding([.bottom, .horizontal])
                .frame(maxWidth: 350)
        }
        .background {
            Capsule()
                .fill(.indigo.opacity(0.5))
                .blur(radius: 60)
        }
        .foregroundStyle(.white)
        .padding(.vertical)
        .padding(.top, 40)
        .multilineTextAlignment(.center)
    }
    
    @ViewBuilder
    private var subscriptionName: some View {
        Text("Backyard Birds Pass")
    }
    
    @ViewBuilder
    private var title: some View {
        if showPremiumUpgrade {
            Text("Premium")
        } else {
            subscriptionName
        }
    }
    
    @ViewBuilder
    private var description: some View {
        if showPremiumUpgrade {
            Text("""
                Early access to new bird species and enhanced journaling for the \
                most avid bird watchers.
                """,
                comment: "Marketing text to advertise Backyard Birds Pass Premium."
            )
        } else {
            Text("""
                More birdhouses and feeders with unlimited backyards for happy \
                habitats
                """,
                comment: "Marketing text to advertise Backyard Birds Pass."
            )
        }
    }
}

private struct SkyBackground: View {
    var body: some View {
        BackyardSkyView(timeInterval: skyTimeInterval)
            .overlay(alignment: .bottom) {
                Ellipse()
                    .fill(.white.opacity(0.2))
                    .frame(width: 800, height: 400)
                    .offset(y: 200)
            }
            .overlay(alignment: .top) {
                Image(.clouds)
                    .resizable()
                    .scaledToFill()
                    .hueRotation(.degrees(70))
                    .frame(height: 200)
            }
    }
}

#Preview {
    ZStack {
        BackyardBirdsPassShop()
    }
    .backyardBirdsDataContainer(inMemory: true)
}
