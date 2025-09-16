//
//  Environment.swift
//  Dub
//
//  Created by Ian MacCallum on 9/11/25.
//

import Foundation

#if canImport(SwiftUI)
import SwiftUI

public struct DubKey: EnvironmentKey {
    public static var defaultValue: Dub {
        Dub.shared
    }

    public typealias Value = Dub

}

@available(macOS 10.15, *)
public extension EnvironmentValues {
    var dub: Dub {
        get { self[DubKey.self] }
        set { self[DubKey.self] = newValue }
    }
}

#endif
