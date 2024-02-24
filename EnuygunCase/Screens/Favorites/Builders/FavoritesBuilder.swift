//
//  FavoritesBuilder.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation

protocol FavoritesBuilder {
    func build() -> FavoritesViewController
}

final class FavoritesBuilderImpl: FavoritesBuilder {
    func build() -> FavoritesViewController {
        let favoritesManager = FavoritesManager.shared
        let useCase = FavoritesUseCaseImpl(favoritesManager: favoritesManager)
        let viewModel = FavoritesViewModelImpl(favoritesUseCase: useCase)
        let uiElementsProvider = FavoritesUIElementsProviderImpl()
        let viewController = FavoritesViewController()
        viewController.inject(pr: uiElementsProvider, vm: viewModel)
        return viewController
    }
}
