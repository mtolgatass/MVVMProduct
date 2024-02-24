//
//  Endpoint.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 23.02.2024.
//

import Foundation

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    func urlRequest() throws -> URLRequest
}

extension Endpoint: EndpointProtocol {
    var baseURL: String {
        return "https://dummyjson.com"
    }
    
    var path: String {
        switch self {
        case .list: return "/products"
        case .search: return "/products/search"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .list: return [EndpointParameters.limit.rawValue: 200]
        case .search(let query): return [EndpointParameters.limit.rawValue: 200,
                                         EndpointParameters.query.rawValue: query]
        }
    }
    
    func urlRequest() throws -> URLRequest {
        guard var component = URLComponents(string: baseURL + path) else {
            throw NetworkError.invalidURL
        }
        
        component.queryItems = parameters?.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        guard let url = component.url else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        return request
    }
}
