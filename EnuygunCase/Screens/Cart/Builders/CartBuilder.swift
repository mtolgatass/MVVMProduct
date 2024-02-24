//
//  CartBuilder.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation

protocol CartBuilder {
    func build() -> CartViewController
}

final class CartBuilderImpl: CartBuilder {
    func build() -> CartViewController {
        let cartManager = CartManager.shared
        let useCase = CartUseCaseImpl(cartManager: cartManager)
        let viewModel = CartViewModelImpl(cartUseCase: useCase)
        let uiElementsProvider = CartUIElementsProviderImpl()
        let viewController = CartViewController()
        viewController.inject(pr: uiElementsProvider, vm: viewModel)
        return viewController
    }
}
