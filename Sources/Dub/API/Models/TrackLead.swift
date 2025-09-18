//
//  TrackLead.swift
//  Dub
//
//  Created by Ian MacCallum on 9/18/25.
//

import Foundation

public struct TrackLeadRequestBody: Codable, Sendable {
    public let clickId: String
    public let eventName: String
    public let customerExternalId: String
    public let customerName: String?
    public let customerEmail: String?
    public let customerAvatar: String?
    public let mode: TrackLeadMode
    public let eventQuantity: Int?
    public let metadata: Metadata?
    
    public init(
        clickId: String,
        eventName: String,
        customerExternalId: String,
        customerName: String? = nil,
        customerEmail: String? = nil,
        customerAvatar: String? = nil,
        mode: TrackLeadMode = .async,
        eventQuantity: Int? = nil,
        metadata: Metadata? = nil
    ) {
        self.clickId = clickId
        self.eventName = eventName
        self.customerExternalId = customerExternalId
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.customerAvatar = customerAvatar
        self.mode = mode
        self.eventQuantity = eventQuantity
        self.metadata = metadata
    }
}

public enum TrackLeadMode: String, Codable, Sendable {
    case async
    case wait
    case deferred
}

public struct TrackLeadResponse: Codable, Sendable {
    public let click: Click
    public let link: Link?
    public let customer: Customer
}
