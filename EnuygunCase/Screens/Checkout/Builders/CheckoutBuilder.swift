//
//  CheckoutBuilder.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation

protocol CheckoutBuilder {
    func build() -> CheckoutViewController
}

final class CheckoutBuilderImpl: CheckoutBuilder {
    func build() -> CheckoutViewController {
        let cartManager = CartManager.shared
        let useCase = CheckoutUseCaseImpl(cartManager: cartManager)
        let viewModel = CheckoutViewModelImpl(checkoutUseCase: useCase)
        let uiElementsProvider = CheckoutUIElementsProviderImpl()
        let viewController = CheckoutViewController()
        viewController.inject(pr: uiElementsProvider, vm: viewModel)
        return viewController
    }
}
