//
//  ProductListUseCaseMock.swift
//  EnuygunCaseTests
//
//  Created by Tolga Taş on 25.02.2024.
//

import Foundation
@testable import EnuygunCase

class ProductListUseCaseMock: ProductListUseCase {
    var getProductListResult: Result<ProductListResponseModel, NetworkError> = .success(ProductListResponseModel(products: [], total: 0))
    var searchProductResult: Result<ProductSearchResponseModel, NetworkError> = .success(ProductSearchResponseModel(products: [], total: 0))

    func getProductList(completion: @escaping (Result<ProductListResponseModel, NetworkError>) -> Void) {
        completion(getProductListResult)
    }

    func searchProduct(_ query: String, completion: @escaping (Result<ProductSearchResponseModel, NetworkError>) -> Void) {
        completion(searchProductResult)
    }
}
