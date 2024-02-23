//
//  NetworkManager.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 23.02.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let urlSession = URLSession.shared
        do {
            let urlRequest = try endpoint.urlRequest()
            
            urlSession.dataTask(with: urlRequest) { data, response, error in
                if let _ = error {
                    DispatchQueue.main.async {
                        completion(.failure(.unknownError))
                    }
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    DispatchQueue.main.async {
                        completion(.failure(.invalidResponse))
                    }
                    return
                }
                
                if !(200...299).contains(httpResponse.statusCode) {
                    DispatchQueue.main.async {
                        completion(.failure(.serverError))
                    }
                    return
                }
                
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(decodedData))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(.decodingError))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(.invalidData))
                    }
                }
            }.resume()
        } catch {
            DispatchQueue.main.async {
                completion(.failure(.invalidURL))
            }
        }
    }
}
