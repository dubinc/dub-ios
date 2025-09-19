import Foundation

public struct DubApiError: LocalizedError, Codable {
    public let code: Code
    public let statusCode: Int
    public let message: String
    public let docUrl: String?

    public var errorDescription: String? {
        return message
    }

    public enum Code: Codable, Sendable {
        case badRequest
        case notFound
        case internalServerError
        case unauthorized
        case forbidden
        case rateLimitExceeded
        case inviteExpired
        case invitePending
        case exceededLimit
        case conflict
        case unprocessableEntity
        case unknown(String)

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)
            
            switch value {
            case "bad_request": self = .badRequest
            case "not_found": self = .notFound
            case "internal_server_error": self = .internalServerError
            case "unauthorized": self = .unauthorized
            case "forbidden": self = .forbidden
            case "rate_limit_exceeded": self = .rateLimitExceeded
            case "invite_expired": self = .inviteExpired
            case "invite_pending": self = .invitePending
            case "exceeded_limit": self = .exceededLimit
            case "conflict": self = .conflict
            case "unprocessable_entity": self = .unprocessableEntity
            default: self = .unknown(value)
            }
        }
    }
}
