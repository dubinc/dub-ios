//
//  DubError.swift
//  Dub
//
//  Created by Ian MacCallum on 9/15/25.
//

import Foundation

public enum DubError: LocalizedError {
    case trackingNotAuthorized
    case missingClick
    case notConfigured
    case invalidResponse
    case requestFailed(String)

    public var errorDescription: String? {
        switch self {
            case .trackingNotAuthorized:
            return "Tracking is not authorized."
        case .missingClick:
            return "Missing click."
        case .notConfigured:
            return "Not configured."
        case .invalidResponse:
            return "Invalid response."
        case .requestFailed(let message):
            return message
        }
    }
}
