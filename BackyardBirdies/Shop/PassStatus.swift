//
//  PassStatus.swift
//  BackyardBirdies
//
//  Created by Patrick Charlson on 3/8/2025.
//

import SwiftUI
import StoreKit
import OSLog

private let logger = Logger(subsystem: "BackyardBirds", category: "BackyardBirdsPassStatus")

nonisolated enum PassStatus: Comparable, Hashable {
    case notSubscribed
    case individual
    case family
    case premium
    
    init(levelOfService: Int) {
        self = switch levelOfService {
        case 1: .premium
        case 2: .family
        case 3: .individual
        default : .notSubscribed
        }
    }
    
    nonisolated init?(productID: Product.ID, ids: PassIdentifiers) {
        switch productID {
        case ids.individual: self = .individual
        case ids.family: self = .family
        case ids.premium: self = .premium
        default: return nil
        }
    }
}

extension EnvironmentValues {
    
    private enum PassStatusEnvrionmentKey: EnvironmentKey {
        static let defaultValue: PassStatus = .premium
    }
    
    fileprivate(set) var passStatus: PassStatus {
        get { self[PassStatusEnvrionmentKey.self] }
        set { self[PassStatusEnvrionmentKey.self] = newValue }
    }
}

private struct PassStatusTaskModifier: ViewModifier {
    @Environment(\.passIDs) private var passIDs
    @Environment(\.modelContext) private var modelContext
    
    @State private var state: EntitlementTaskState<PassStatus> = .loading
    
    func body(content: Content) -> some View {
        content
            .subscriptionStatusTask(for: passIDs.group) { state in
                logger.info("Checking subscription status")
                guard let birdBrain = BirdBrain.shared else { fatalError("BirdBrain was nil.") }
                self.state = await state.map { @Sendable [passIDs] statuses in
                    await birdBrain.status(
                        for: statuses,
                        ids: passIDs
                    )
                }
                switch self.state {
                case .failure(let error):
                    logger.error("Failed to check subscription status: \(error)")
                    DataGeneration.generateVisitorEvents(
                        modelContext: modelContext,
                        includeEarlyAccessSpecies: false
                    )
                case .success(let status):
                    DataGeneration.generateVisitorEvents(
                        modelContext: modelContext, includeEarlyAccessSpecies: status == .premium
                    )
                case .loading: break
                @unknown default: break
                }
                logger.info("Finished checking subscription status")
            }
            .environment(\.passStatus, state.value ?? .notSubscribed)
    }
}

extension View {
    func subscriptionPassStatusTask() -> some View {
        modifier(PassStatusTaskModifier())
    }
}
