//
//  TrackOpenResponse.swift
//  Dub
//
//  Created by Ian MacCallum on 9/11/25.
//

import Foundation

public struct TrackOpenResponse: Codable, Sendable {
    public let clickId: String?
    public let link: Link?
}
