//
//  TrackOpenRequestBody.swift
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
    public struct Click: Codable, Sendable {
        public let id: String
    }
    
    public struct Customer: Codable, Sendable {
        public let name: String?
        public let email: String?
        public let avatar: String?
        public let externalId: String?
    }
    
    public let click: Click
    public let link: Link?
    public let customer: Customer
}


public struct TrackSaleRequestBody: Codable, Sendable {
    public let customerExternalId: String
    public let amount: Int
    public let currency: String
    public let eventName: String?
    public let paymentProcessor: PaymentProcessor
    public let invoiceId: String?
    public let metadata: Metadata?
    public let leadEventName: String?
    public let clickId: String?
    public let customerName: String?
    public let customerEmail: String?
    public let customerAvatar: String?
    
    public init(
        customerExternalId: String,
        amount: Int,
        currency: String = "usd",
        eventName: String? = "Purchase",
        paymentProcessor: PaymentProcessor = .custom,
        invoiceId: String? = nil,
        metadata: Metadata? = nil,
        leadEventName: String? = nil,
        clickId: String? = nil,
        customerName: String? = nil,
        customerEmail: String? = nil,
        customerAvatar: String? = nil
    ) {
        self.customerExternalId = customerExternalId
        self.amount = amount
        self.currency = currency.lowercased()
        self.eventName = eventName
        self.paymentProcessor = paymentProcessor
        self.invoiceId = invoiceId
        self.metadata = metadata
        self.leadEventName = leadEventName
        self.clickId = clickId
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.customerAvatar = customerAvatar
    }
}

public enum PaymentProcessor: String, Codable, Sendable {
    case stripe
    case shopify
    case polar
    case paddle
    case revenuecat
    case custom
}

public struct TrackSaleResponse: Codable, Sendable {
    public let eventName: String
    public let customer: Customer?
    public let sale: Sale?
    
    public struct Customer: Codable, Sendable {
        public let id: String
        public let name: String?
        public let email: String?
        public let avatar: String?
        public let externalId: String?
    }
    
    public struct Sale: Codable, Sendable {
        public let amount: Int
        public let currency: String
        public let paymentProcessor: String
        public let invoiceId: String?
        public let metadata: Metadata?
    }
}
