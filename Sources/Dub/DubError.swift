//
//  DubError.swift
//  Dub
//
//  Created by Ian MacCallum on 9/15/25.
//

import Foundation

public enum DubError: LocalizedError {
    case missingClick
    case notConfigured
    case invalidResponse
    case requestFailed(String)
}
