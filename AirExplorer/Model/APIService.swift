//
//  APIService.swift
//  AirExplorer
//
//  Created by alumne on 19/01/2026.
//

import Foundation

struct JSONBinResponse<T: Decodable>: Decodable {
    let record: T
}

struct APIService {
    
    private static let apiURL = "https://api.jsonbin.io/v3/b/696e4d99ae596e708fe6d1a4"
    private static let xMasterKey = "$2a$10$NSz0xjFY372Hjmc259N6qeqMFhtFl93dNuIfTYbn5chJ9rHIuO9hG"
    
    static func fetchAircrafts(completion: @escaping (Result<[Aircraft], APIError>) -> Void) {
        
        guard let url = URL(string: apiURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(xMasterKey, forHTTPHeaderField: "X-Master-Key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let errorResponse = error {
                completion(.failure(.urlSessionError(errorResponse)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            if let dataResponse = data {
                do {
                    let decoded = try JSONDecoder().decode(JSONBinResponse<[Aircraft]>.self, from: dataResponse)
                    completion(.success(decoded.record))
                } catch {
                    completion(.failure(.decodingFailed(error)))
                }
            }
        }
        task.resume()
    }
}
