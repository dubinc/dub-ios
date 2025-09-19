//
//  Storage.swift
//  Dub
//
//  Created by Ian MacCallum on 9/11/25.
//

import Foundation

class Storage {
    private let clickIdKey = "dub:click_id"

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    var clickId: String? {
        get {
            userDefaults.string(forKey: clickIdKey)
        }
        set {
            if let newValue = newValue {
                userDefaults.set(newValue, forKey: clickIdKey)
            } else {
                userDefaults.removeObject(forKey: clickIdKey)
            }
        }
    }

    func clearClickId() {
        userDefaults.removeObject(forKey: clickIdKey)
    }
}
