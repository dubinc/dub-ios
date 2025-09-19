//
//  File.swift
//  Dub
//
//  Created by Ian MacCallum on 9/18/25.
//

import Foundation

public protocol IdConvertible {
    var id: String { get }
}

extension String: IdConvertible {
    public var id: String { self }
}

extension Int: IdConvertible {
    public var id: String { String(self) }
}

extension UUID: IdConvertible {
    public var id: String { self.uuidString }
}
