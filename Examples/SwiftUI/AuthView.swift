//
//  AuthView.swift
//  Dub
//
//  Created by Ian MacCallum on 9/15/25.
//

import SwiftUI

struct AuthView: View {
    let onAuthenticated: (_ userId: String, _ name: String, _ email: String) -> Void
    
    @State private var name: String = "Tim"
    @State private var email: String = "tim@apple.com"
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {

                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Name")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        TextField("Enter your name", text: $name)
                            .textFieldStyle(.plain)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .autocapitalization(.words)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        TextField("Enter your email", text: $email)
                            .textFieldStyle(.plain)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    onAuthenticated(UUID().uuidString, name, email)
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            name.isEmpty || email.isEmpty ? 
                            Color.blue.opacity(0.5) : 
                            Color.blue
                        )
                        .cornerRadius(16)
                }
                .disabled(name.isEmpty || email.isEmpty)
            }
            .padding(24)
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AuthView { userId, name, email in
        print("User authenticated: \(name)")
    }
}
