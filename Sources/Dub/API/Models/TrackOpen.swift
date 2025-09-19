//
//  TrackOpen.swift
//  Dub
//
//  Created by Ian MacCallum on 9/11/25.
//

import Foundation

public struct TrackOpenRequestBody: Codable, Sendable {
    public let deepLink: String?
    public let dubDomain: String?
    
    public init(deepLink: String? = nil, dubDomain: String? = nil) {
        self.deepLink = deepLink
        self.dubDomain = dubDomain
    }
}

public struct TrackOpenResponse: Codable, Sendable {
    public let clickId: String?
    public let link: Link?
}

