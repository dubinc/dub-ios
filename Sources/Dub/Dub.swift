import Foundation

#if os(iOS) || os(visionOS)
import UIKit
#elseif os(macOS)
import AppKit
#elseif os(watchOS)
import WatchKit
#elseif os(tvOS)
import TVUIKit
#endif

public actor Dub {
    // MARK: - Dub instance
    private static var _shared: Dub!

    public static var shared: Dub {
        guard let dub = _shared else {
            fatalError("Dub.setup must be called")
        }

        return dub
    }

    // MARK: - Services
    private lazy var api: DubAPI = DubAPI(baseUrl: baseUrl, publishableKey: publishableKey)
    private lazy var storage = Storage()

    // MARK: - Configuration
    private var baseUrl: URL?
    private var publishableKey: String
    private let domain: String

    // MARK: - Init
    private init(
        publishableKey: String,
        domain: String,
        baseUrl: URL? = nil
    ) {
        self.publishableKey = publishableKey
        self.domain = domain
        self.baseUrl = baseUrl
    }

    // MARK: - Setup
    public static func setup(
        publishableKey: String,
        domain: String,
        baseUrl: URL? = nil
    ) {
        _shared = Dub(publishableKey: publishableKey, domain: domain, baseUrl: baseUrl)
    }

    // MARK: - Tracking Methods
    public func trackOpen(deepLink: URL? = nil) async throws -> TrackOpenResponse {
        let body: TrackOpenRequestBody

        if let deepLink = deepLink {
            // Use the provided deep link
            body = TrackOpenRequestBody(deepLink: deepLink.absoluteString, dubDomain: domain)
        } else {
#if os(iOS) || os(watchOS) || os(tvOS)
            let clipboard = UIPasteboard.general.string
#elseif os(macOS)
            let clipboard = NSPasteboard.general.string(forType: .URL)
#else
            let clipboard: String? = nil
#endif

            if let deepLink = clipboard,  let url = resolveUrl(for: deepLink) {
                // Clipboard-based tracking
                body = TrackOpenRequestBody(deepLink: url.absoluteString, dubDomain: domain)
            } else {
                // IP-based tracking fallback
                body = TrackOpenRequestBody(dubDomain: domain)
            }
        }

        do {
            let response = try await self.api.trackOpen(body)

            storage.clickId = response.clickId

            return response
        } catch {
            throw error
        }
    }

    public func trackLead(
        eventName: String,
        customerExternalId: String,
        customerName: String? = nil,
        customerEmail: String? = nil,
        customerAvatar: String? = nil,
        mode: TrackLeadMode = .async,
        eventQuantity: Int? = nil,
        metadata: Metadata? = nil
    ) async throws -> TrackLeadResponse {
        guard let clickId = storage.clickId else {
            throw DubError.missingClick
        }

        let body = TrackLeadRequestBody(
            clickId: clickId,
            eventName: eventName,
            customerExternalId: customerExternalId,
            customerName: customerName,
            customerEmail: customerEmail,
            customerAvatar: customerAvatar,
            mode: mode,
            eventQuantity: eventQuantity,
            metadata: metadata
        )

        do {
            let response = try await api.trackLead(body)

            storage.clearClickId()

            return response
        } catch {
            throw error
        }
    }

    public func trackSale(
        customerExternalId: String,
        amount: Int,
        currency: String = "usd",
        eventName: String? = "Purchase",
        paymentProcessor: PaymentProcessor = .custom,
        invoiceId: String? = nil,
        metadata: Metadata? = nil,
        leadEventName: String? = nil,
        customerName: String? = nil,
        customerEmail: String? = nil,
        customerAvatar: String? = nil
    ) async throws -> TrackSaleResponse {
        let body = TrackSaleRequestBody(
            customerExternalId: customerExternalId,
            amount: amount,
            currency: currency,
            eventName: eventName,
            paymentProcessor: paymentProcessor,
            invoiceId: invoiceId,
            metadata: metadata,
            leadEventName: leadEventName,
            clickId: storage.clickId,
            customerName: customerName,
            customerEmail: customerEmail,
            customerAvatar: customerAvatar
        )

        return try await api.trackSale(body)
    }

    // MARK: - Helpers
    private func resolveUrl(for clipboardText: String) -> URL? {
        guard !clipboardText.isEmpty else { return nil }

        // If the pasted content is a valid url with the dub domain, use it
        if clipboardText.contains(domain), let url = URL(string: clipboardText) {
            return url
        }

        // Fallback and try to construct a url from the dub domain and the
        // text (in the case it is a short link code that was copied)
        if let url = URL(string: "\(domain)/\(clipboardText)") {
            return url
        }

        return nil
    }
}
