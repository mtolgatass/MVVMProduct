//
//  ProductListService.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 23.02.2024.
//

import Foundation

protocol ProductListService {
    func getProducts(completion: @escaping (Result<ProductListResponseModel, NetworkError>) -> Void)
}

struct ProductListServiceImpl: ProductListService {
    func getProducts(completion: @escaping (Result<ProductListResponseModel, NetworkError>) -> Void) {
        NetworkManager.shared.request(Endpoint.list) { (result: Result<ProductListResponseModel, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
