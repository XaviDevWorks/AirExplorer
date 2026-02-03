import Foundation

class APIService {
    static let shared = APIService()
    
    private let baseURL = "https://api.jsonbin.io/v3/b/696e4d99ae596e708fe6d1a4"
    private let apiKey = "$2a$10$NSz0xjFY372Hjmc259N6qeqMFhtFl93dNuIfTYbn5chJ9rHIuO9hG"
    
    func fetchAircrafts(completion: @escaping (Result<[Aircraft], APIError>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Master-Key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("📡 Solicitando datos de la API...")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Manejo de errores de red
            if let error = error {
                print("❌ Error de red: \(error.localizedDescription)")
                completion(.failure(.networkError))
                return
            }
            
            // Verificar respuesta HTTP
            guard let httpResponse = response as? HTTPURLResponse else {
                print("❌ Respuesta HTTP inválida")
                completion(.failure(.serverError("Respuesta inválida")))
                return
            }
            
            print("📊 Status code: \(httpResponse.statusCode)")
            
            // Verificar código de estado
            guard (200...299).contains(httpResponse.statusCode) else {
                print("❌ Error del servidor: \(httpResponse.statusCode)")
                completion(.failure(.serverError("Código: \(httpResponse.statusCode)")))
                return
            }
            
            // Verificar datos recibidos
            guard let data = data else {
                print("❌ Sin datos en la respuesta")
                completion(.failure(.serverError("Sin datos")))
                return
            }
            
            // Debug: imprimir JSON recibido
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📦 JSON recibido (primeros 500 caracteres):")
                print(String(jsonString.prefix(500)))
            }
            
            do {
                // Decodificar la respuesta de JSONBin
                let jsonResponse = try JSONDecoder().decode(JSONBinResponse.self, from: data)
                
                // Extraer el array de aircrafts del record
                let aircrafts = jsonResponse.record.aircrafts
                print("✅ Datos decodificados: \(aircrafts.count) aviones")
                
                completion(.success(aircrafts))
            } catch let decodingError {
                print("❌ Error decodificando JSON: \(decodingError)")
                print("Error localizado: \(decodingError.localizedDescription)")
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

// Estructura para la respuesta de JSONBin
struct JSONBinResponse: Codable {
    let record: Record
}

struct Record: Codable {
    let aircrafts: [Aircraft]
}
