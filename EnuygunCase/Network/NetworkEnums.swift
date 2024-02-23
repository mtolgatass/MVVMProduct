//
//  NetworkEnums.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 23.02.2024.
//

import Foundation

enum Endpoint {
    case list
    case search(query: String)
}

enum EndpointParameters: String {
    case limit
    case query
}

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodingError
    case serverError
    case unknownError
}
