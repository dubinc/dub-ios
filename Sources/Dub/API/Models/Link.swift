//
//  TrackOpenRequestBody.swift
//  Dub
//
//  Created by Ian MacCallum on 9/11/25.
//

import Foundation

public struct Link: Codable, Sendable {
    public let id: String
    public let domain: String
    public let key: String
    public let url: String
}
