//
//  Customer.swift
//  Dub
//
//  Created by Ian MacCallum on 9/18/25.
//

import Foundation

public struct Customer: Codable, Sendable {
    public let name: String?
    public let email: String?
    public let avatar: String?
    public let externalId: String?
}

