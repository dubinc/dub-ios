import Foundation
import Combine

internal actor NetworkClient {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession) {
        self.session = session
        self.decoder = JSONDecoder()
    }
    
    func request<T: Decodable>(_ request: URLRequest, responseType: T.Type) async throws -> T {
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noData
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            guard let dubApiError = try? JSONDecoder().decode(DubApiError.self, from: data) else {
                throw NetworkError.httpError(httpResponse.statusCode)
            }

            throw dubApiError
        }

        return try decoder.decode(responseType, from: data)
    }
    
    // MARK: - Error handling
    private func mapError(_ error: Error, data: Data? = nil) -> NetworkError {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost:
                return .networkUnavailable
            case .timedOut:
                return .timeout
            default:
                return .unknown(error)
            }
        }

        return .unknown(error)
    }
}
