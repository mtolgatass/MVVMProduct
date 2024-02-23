//
//  SearchProductService.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 23.02.2024.
//

import Foundation

protocol SearchProductService {
    func searchProduct(_ query: String, completion: @escaping (Result<ProductSearchResponseModel, NetworkError>) -> Void)
}

struct SearchProductServiceImpl: SearchProductService {
    func searchProduct(_ query: String, completion: @escaping (Result<ProductSearchResponseModel, NetworkError>) -> Void) {
        NetworkManager.shared.request(Endpoint.search(query: query)) { (result: Result<ProductSearchResponseModel, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
