//
//  ProductDetailBuilder.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation

protocol ProductDetailBuilder {
    func build(product: Product) -> ProductDetailViewController
}

final class ProductDetailBuilderImpl: ProductDetailBuilder {
    func build(product: Product) -> ProductDetailViewController {
        let favoritesManager = FavoritesManager.shared
        let cartManager = CartManager.shared
        let useCase = ProductDetailUseCaseImpl(favoritesManager: favoritesManager, cartManager: cartManager)
        let viewModel = ProductDetailViewModelImpl(useCase: useCase, product: product)
        let uiElementsProvider = ProductDetailUIElementsProviderImpl()
        let viewController = ProductDetailViewController()
        viewController.inject(pr: uiElementsProvider, vm: viewModel)
        return viewController
    }
}
