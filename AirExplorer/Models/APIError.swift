import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case serverError(String)
    case decodingError
    case networkError
    case unauthorized
    case custom(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL inválida"
        case .serverError(let message):
            return "Error del servidor: \(message)"
        case .decodingError:
            return "Error al procesar los datos"
        case .networkError:
            return "Error de conexión. Verifica tu internet"
        case .unauthorized:
            return "No autorizado"
        case .custom(let message):
            return message
        }
    }
}
