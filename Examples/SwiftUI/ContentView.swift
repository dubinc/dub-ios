//
//  ContentView.swift
//  Dub
//
//  Created by Ian MacCallum on 9/15/25.
//

import SwiftUI
import Dub

struct ContentView: View {

    @Environment(\.dub) var dub: Dub

    @State private var deepLinkURL: String?

    @State private var shouldNavigate = false
    @State private var presentAuthenticationScreen = false

    @State private var userId: String?
    @State private var productPurchased = false

    @AppStorage("is_first_launch") private var isFirstLaunch = true

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 32, height: 32)
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Click Tracking")
                                .font(.headline)
                            Text("Automatically tracks app opens from deep links and deferred deep links on launch")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }

                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(userId != nil ? Color.green : Color.blue)
                                .frame(width: 32, height: 32)
                            if userId != nil {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            } else {
                                Text("2")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Lead Tracking")
                                .font(.headline)
                            Text("Track user signups and form submissions")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            if userId == nil {
                                Button("Sign Up") {
                                    presentAuthenticationScreen = true
                                }
                                .buttonStyle(.borderedProminent)
                                .padding(.top, 4)
                            }
                        }
                    }

                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(productPurchased ? Color.green : Color.blue)
                                .frame(width: 32, height: 32)
                            if productPurchased {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            } else {
                                Text("3")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Sale Tracking")
                                .font(.headline)
                            Text("Track purchases and revenue from your links")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            if let userId, !productPurchased {
                                Button("Purchase Product") {
                                    // Handle purchase action
                                    trackSale(
                                        customerExternalId: userId,
                                        amount: 10000,
                                        eventName: "Purchase",
                                        invoiceId: UUID().uuidString
                                    )
                                    productPurchased = true
                                }
                                .buttonStyle(.borderedProminent)
                                .padding(.top, 4)
                            }
                        }
                    }
                    .opacity(userId == nil ? 0.5 : 1.0)
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)

                if productPurchased {
                    Button("Reset") {
                        userId = nil
                        productPurchased = false
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            .onOpenURL { url in
                trackOpen(deepLink: url)
            }
            .onAppear {
                if isFirstLaunch {
                    trackOpen()
                    isFirstLaunch = false
                }
            }
            .navigationDestination(isPresented: $shouldNavigate) {
                if let url = deepLinkURL {
                    DetailView(url: url)
                }
            }
            .sheet(isPresented: $presentAuthenticationScreen) {
                AuthView { userId, name, email in
                    presentAuthenticationScreen = false
                    trackLead(customerExternalId: userId, name: name, email: email)
                    self.userId = userId
                }
            }
            .navigationTitle("Dub SwiftUI Demo")
        }
    }

    // Step 1: Track the open
    // Call `dub.trackOpen` from onAppear only on the first launch and `onOpenURL`
    private func trackOpen(deepLink: URL? = nil) {
        Task {
            do {
                let response = try await dub.trackOpen(deepLink: deepLink)

                // Navigate to final link via link.url
                guard let url = response.link?.url else {
                    return
                }

                deepLinkURL = url
                shouldNavigate = true
            } catch let error as DubError {
                print(error.localizedDescription)
            }
        }
    }

    // Step 1: Track a lead event
    // Learn more about lead tracking [here](https://dub.co/docs/conversions/leads/client-side)
    private func trackLead(customerExternalId: String, name: String, email: String) {
        Task {
            do {
                let response = try await dub.trackLead(
                    eventName: "User Sign Up",
                    customerExternalId: customerExternalId,
                    customerName: name,
                    customerEmail: email
                )

                print(response)
            } catch let error as DubError {
                print(error.localizedDescription)
            }
        }
    }

    // Step 3: Track a sale event whenever a user completes a purchase in your app.
    // Learn more about sale tracking [here](https://dub.co/docs/conversions/sales/client-side)
    private func trackSale(
        customerExternalId: String,
        amount: Int,
        currency: String = "usd",
        eventName: String? = "Purchase",
        paymentProcessor: PaymentProcessor = .custom,
        invoiceId: String? = nil,
        metadata: Metadata? = nil,
        leadEventName: String? = nil,
        customerName: String? = nil,
        customerEmail: String? = nil,
        customerAvatar: String? = nil
    ) {
        Task {
            do {
                let response = try await dub.trackSale(
                    customerExternalId: customerExternalId,
                    amount: amount,
                    currency: currency,
                    eventName: eventName,
                    paymentProcessor: paymentProcessor,
                    invoiceId: invoiceId,
                    metadata: metadata,
                    leadEventName: leadEventName,
                    customerName: customerName,
                    customerEmail: customerEmail,
                    customerAvatar: customerAvatar
                )

                print(response)
            } catch let error as DubError {
                print(error.localizedDescription)
            }
        }
    }
}

struct DetailView: View {
    let url: String

    var body: some View {
        Text("Navigated to: \(url)")
    }
}

#Preview {
    ContentView()
        .environment(\.dub, Dub.shared)
}
