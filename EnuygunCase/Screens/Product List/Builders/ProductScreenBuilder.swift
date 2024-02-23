//
//  ProductScreenBuilder.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 23.02.2024.
//

import Foundation

protocol ProductScreenBuilder {
    func build() -> ProductListViewController
}

final class ProductScreenBuilderImpl: ProductScreenBuilder {
    func build() -> ProductListViewController {
        let vc = ProductListViewController()
        let productListService = ProductListServiceImpl()
        let searchProductService = SearchProductServiceImpl()
        let useCase = ProductListUseCaseImpl(productListService: productListService, searchProductService: searchProductService)
        let vm = ProductListViewModelImpl(productListUseCase: useCase)
        let provider = ProductListUIElementsProviderImpl()
        vc.inject(pr: provider, vm: vm)
        return vc
    }
}
