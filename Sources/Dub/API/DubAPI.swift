//
//  DubAPI.swift
//  Dub
//
//  Created by Ian MacCallum on 9/11/25.
//

import Foundation
import Combine

actor DubAPI {

    private lazy var networkClient: NetworkClient = {
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        config.allowsCellularAccess = true
        let session = URLSession(configuration: config)

        return NetworkClient(session: session)
    }()

    private let baseUrl: URL
    private let publishableKey: String
    
    init(baseUrl: URL?, publishableKey: String) {
        self.baseUrl = baseUrl ?? URL(string: "https://api.dub.co")!
        self.publishableKey = publishableKey
    }
    
    // MARK: - Endpoints
    // MARK: - Track Open - POST /track/open
    func trackOpen(_ body: TrackOpenRequestBody) async throws -> TrackOpenResponse {
        let url = try buildUrl(path: "/track/open")

        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(publishableKey)", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 30.0
        request.httpBody = try JSONEncoder().encode(body)

        return try await networkClient.request(request, responseType: TrackOpenResponse.self)
    }

    // MARK: - Track Lead (Client) - POST /track/lead/client
    func trackLead(_ body: TrackLeadRequestBody) async throws -> TrackLeadResponse {
        let url = try buildUrl(path: "/track/lead/client")

        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(publishableKey)", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 30.0
        request.httpBody = try JSONEncoder().encode(body)

        return try await networkClient.request(request, responseType: TrackLeadResponse.self)
    }

    // MARK: - Track Sale (Client) - POST /track/sale/client
    func trackSale(_ body: TrackSaleRequestBody) async throws -> TrackSaleResponse {
        let url = try buildUrl(path: "/track/sale/client")

        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(publishableKey)", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 30.0
        request.httpBody = try JSONEncoder().encode(body)

        return try await networkClient.request(request, responseType: TrackSaleResponse.self)
    }

    // MARK: - Utilities
        private func buildUrl(path: String) throws -> URL {
        guard let url = URL(string: baseUrl.absoluteString + path) else {
            throw NetworkError.invalidURL
        }
            
        return url
    }
}
