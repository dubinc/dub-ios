import Foundation

public enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case decodingError(Error)
    case httpError(Int)
    case networkUnavailable
    case timeout
    case unauthorized
    case rateLimited
    case unknown(Error)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .httpError(let code):
            return "HTTP error: \(code)"
        case .networkUnavailable:
            return "Network unavailable"
        case .timeout:
            return "Request timeout"
        case .unauthorized:
            return "Unauthorized request"
        case .rateLimited:
            return "Rate limited"
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}
