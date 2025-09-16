//
//  DubApp.swift
//  Dub
//
//  Created by Ian MacCallum on 9/15/25.
//

import SwiftUI
import Dub

@main
struct DubApp: App {
    // Step 1: Obtain your Dub domain and publishable key
    // Generate your publishable key from
    // your [workspace’s Analytics settings page](https://app.dub.co/settings/analytics)
    // Learn more [here](https://dub.co/docs/conversions/leads/client-side#quickstart)
    private let dubPublishableKey = "<DUB_PUBLISHABLE_KEY>"
    private let dubDomain = "<DUB_DOMAIN>"

    init() {
        // Step 2: Initialize the Dub SDK by calling `setup`
        Dub.setup(publishableKey: dubPublishableKey, domain: dubDomain)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                // Step 3: Expose the `dub` instance as a SwiftUI environment value
                // You may access it by using `@Environment(\.dub) var dub: Dub`
                .environment(\.dub, Dub.shared)
        }
    }
}
