//
//  AccountScreen.swift
//  BackyardBirdies
//
//  Created by patrick charlson on 12/07/2025.
//

import SwiftUI
import SwiftData
import StoreKit

struct AccountScreen: View {
    @Query private var accounts: [Account]
    
    @Environment(\.passStatus) private var passStatus
    @Environment(\.passIDs.group) private var passGroupID
    
    @State private var presentingPassSheet = false
    @State private var presentingEditAccountSheet = false
    @State private var presentingManagePassSheet = false
    
    
    var body: some View {
        NavigationStack {
            if let account = accounts.first, let bird = accounts.first?.bird {
                Form {
                    VStack {
                        BirdIcon(bird: bird)
                            .frame(width: 80, height: 80)
                        
                        Text(account.displayName)
                            .font(.headline.bold())
                            .overlay(alignment: .leading) {
                                (account.isPremiumMember ? Label("Premium Member", systemImage: "bird.fill") : Label("Basic Member", systemImage: "bird"))
                                    .foregroundStyle(.tint)
                                    .labelStyle(.iconOnly)
                                    .imageScale(.large)
                                    .alignmentGuide(.leading) { $0[.trailing] + 4 }
                            }
                        Text("Joined \(account.joinDate.formatted(.dateTime.month(.wide).day(.twoDigits).year()))",
                             comment: "Variable is the calendar date when the person joined.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .listRowInsets(.none)
                    .listRowBackground(Color.clear)
                    
                    Section {
                        if passStatus == .individual || passStatus == .family {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("""
                                     Unlock the complete backyard experience with early access to new bird species and more!
                                     """)
                                Button("Check out Premium \(Image(systemName: "chevron.forward"))") {
                                    presentingPassSheet = true
                                }
                                .font(.callout)
                                .buttonStyle(.borderless)
                            }
                        }
                        if case .notSubscribed = passStatus {
                            Button {
                                presentingPassSheet = true
                            } label: {
                                Label("Get Backyard Birds Pass", systemImage: "wallet.pass")
                            }
                        } else {
                            Button {
                                presentingManagePassSheet = true
                            } label: {
                                manageSubscriptionLabel
                            }
                        }
                    } footer: {
                        if passStatus != .notSubscribed {
                            Text("Backyard Birds Pass: \(String(describing: passStatus))")
                        }
                    }
                    .symbolVariant(.fill)
                    Section {
                        RestorePurchasesButton()
                    }
                }
                .formStyle(.grouped)
                .navigationTitle("Account")
                .toolbar {
                    Button {
                        presentingEditAccountSheet = true
                    } label: {
                        Label("Edit Account", systemImage: "pencil")
                    }
                }
                .sheet(isPresented: $presentingEditAccountSheet) {
                    EditAccountForm(account: account)
                }
                .sheet(isPresented: $presentingPassSheet) {
                    BackyardBirdsPassShop()
                }
                .manageSubscriptionsSheet(
                    isPresented: $presentingManagePassSheet,
                    subscriptionGroupID: passGroupID
                )
            } else {
                ContentUnavailableView("No Account Found", systemImage: "bird")
            }
        }
    }
    
    @ViewBuilder
    private var manageSubscriptionLabel: some View {
        Label {
            Text("Your Backyard Birds Pass: \(String(describing: passStatus))",
                 comment: "The variable is the type of Backyard Birds Pass (such as Premium, Family, and so on)")
        } icon: {
            Image(systemName: "wallet.pass")
        }
    }
}

#Preview {
    AccountScreen()
        .backyardBirdsDataContainer(inMemory: true)
}
