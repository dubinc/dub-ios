//
//  TrackSale.swift
//  Dub
//
//  Created by Ian MacCallum on 9/18/25.
//

import Foundation

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
    case apple
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

}
