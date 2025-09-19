//
//  AuthManager.swift
//  DubSwiftUIDemo
//
//  Created by Ian MacCallum on 9/18/25.
//

import SwiftUI

// MARK: - Auth Manager
class AuthManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?

    func login(user: User) {
        currentUser = user
        isAuthenticated = true
    }

    func logout() {
        currentUser = nil
        isAuthenticated = false
    }
}
