//
//  EditAccountForm.swift
//  BackyardBirdies
//
//  Created by Patrick Charlson on 4/8/2025.
//

import SwiftUI

struct EditAccountForm: View {
    var account: Account
    
    @State private var displayName: String = ""
    @State private var email: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Display Name", text: $displayName)
                        .textInputAutocapitalization(.words)
                        .textContentType(.name)
                        .onSubmit {
                            account.displayName = displayName
                        }
                        .onAppear {
                            displayName = account.displayName
                        }
                }
                Section("Email") {
                    TextField("Email Address", text: $email)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .textContentType(.emailAddress)
                        .onSubmit {
                            account.emailAddress = email
                        }
                        .onAppear {
                            email = account.emailAddress
                        }
                }
            }
            .formStyle(.grouped)
            .navigationTitle("Account Information")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ModelPreview { account in
        EditAccountForm(account: account)
    }
}
