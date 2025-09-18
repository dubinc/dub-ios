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

    public var clickId: String? {
        storage.clickId
    }

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
    /// Tracks the open event for deep links and deferred deep links.
    ///
    /// `trackOpen` should be called under two scenarios:
    ///    1. Any time the application was opened from a url. The function should be called with the `deepLink` parameter.
    ///    2. The first time the application launches, it should be called with no `deepLink`
    /// - Parameter deepLink: The url with which the application was opened.
    /// - Returns: `Structures/TrackOpenResponse`
    @discardableResult
    public func trackOpen(deepLink: URL? = nil) async throws -> TrackOpenResponse {
        let body: TrackOpenRequestBody

        if let deepLink = deepLink {
            // Use the provided deep link
            body = TrackOpenRequestBody(deepLink: deepLink.absoluteString, dubDomain: domain)
        } else {
#if os(iOS) || os(watchOS) || os(tvOS)
            let clipboard = UIPasteboard.general.hasStrings ? UIPasteboard.general.string : nil
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
    
    /// Track a lead for a short link.
    /// - Parameters:
    ///   - eventName: The name of the lead event to track. Can also be used as a unique identifier to associate a given lead event for a customer for a subsequent sale event (via the leadEventName prop in /track/sale). Required string length: 1 - 255. Example: "Sign up"
    ///   - customerExternalId: The unique ID of the customer in your system. Will be used to identify and attribute all future events to this customer. Required string length: 1 - 100
    ///   - customerName: The name of the customer. If not passed, a random name will be generated (e.g. “Big Red Caribou”).
    ///   - customerEmail: The email address of the customer.
    ///   - customerAvatar: The avatar URL of the customer.
    ///   - mode: The mode to use for tracking the lead event. async will not block the request; wait will block the request until the lead event is fully recorded in Dub; deferred will defer the lead event creation to a subsequent request. Available options: async, wait, deferred. Default: async.
    ///   - eventQuantity: The numerical value associated with this lead event (e.g., number of provisioned seats in a free trial). If defined as N, the lead event will be tracked N times.
    ///   - metadata: Additional metadata to be stored with the lead event. Max 10,000 characters.
    /// - Returns: `Structures/TrackLeadResponse`
    @discardableResult
    public func trackLead(
        eventName: String,
        customerExternalId: IdConvertible,
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
            customerExternalId: customerExternalId.id,
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
    
    /// Track a sale for a short link.
    /// - Parameters:
    ///   - customerExternalId: The unique ID of the customer in your system. Will be used to identify and attribute all future events to this customer. Required string length: 1 - 100.
    ///   - amount: The amount of the sale in cents (for all two-decimal currencies). If the sale is in a zero-decimal currency, pass the full integer value (e.g. 1437 JPY). Learn more: https://d.to/currency
    ///   - currency: The currency of the sale. Accepts ISO 4217 currency codes. Sales will be automatically converted and stored as USD at the latest exchange rates. Learn more: https://d.to/currency
    ///   - eventName: The name of the sale event. Recommended format: Invoice paid or Subscription created.
    ///   - paymentProcessor: The payment processor via which the sale was made. Available options: stripe, shopify, polar, paddle, revenuecat, custom.
    ///   - invoiceId: The invoice ID of the sale. Can be used as a idempotency key – only one sale event can be recorded for a given invoice ID.
    ///   - metadata: Additional metadata to be stored with the sale event. Max 10,000 characters when stringified.
    ///   - leadEventName: The name of the lead event that occurred before the sale (case-sensitive). This is used to associate the sale event with a particular lead event (instead of the latest lead event for a link-customer combination, which is the default behavior). For sale tracking without a pre-existing lead event, this field can also be used to specify the lead event name.
    ///   - customerName: [For sale tracking without a pre-existing lead event]: The name of the customer. If not passed, a random name will be generated (e.g. “Big Red Caribou”).
    ///   - customerEmail: [For sale tracking without a pre-existing lead event]: The email address of the customer.
    ///   - customerAvatar: [For sale tracking without a pre-existing lead event]: The avatar URL of the customer.
    /// - Returns: `Structures/TrackSaleResponse`
    @discardableResult
    public func trackSale(
        customerExternalId: IdConvertible,
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
            customerExternalId: customerExternalId.id,
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
