//
//  ProductListUseCase.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 23.02.2024.
//

import Foundation

protocol ProductListUseCase {
    func getProductList(completion: @escaping (Result<ProductListResponseModel, NetworkError>) -> Void)
    func searchProduct(_ query: String, completion: @escaping (Result<ProductSearchResponseModel, NetworkError>) -> Void)
}

struct ProductListUseCaseImpl: ProductListUseCase {
    let productListService: ProductListService
    let searchProductService: SearchProductService
    
    init(productListService: ProductListService, searchProductService: SearchProductService) {
        self.productListService = productListService
        self.searchProductService = searchProductService
    }
    
    func getProductList(completion: @escaping (Result<ProductListResponseModel, NetworkError>) -> Void) {
        productListService.getProducts(completion: completion)
    }
    
    func searchProduct(_ query: String, completion: @escaping (Result<ProductSearchResponseModel, NetworkError>) -> Void) {
        searchProductService.searchProduct(query, completion: completion)
    }
}
