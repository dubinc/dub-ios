//
//  Sale.swift
//  Dub
//
//  Created by Ian MacCallum on 9/18/25.
//

import Foundation

public struct Sale: Codable, Sendable {
    public let amount: Int
    public let currency: String
    public let paymentProcessor: String
    public let invoiceId: String?
    public let metadata: Metadata?
}
