//
//  ProductDetailViewModel.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation

protocol ProductDetailViewModel {
    func updateFavorite()
    var product: Product { get }
    func getProduct() -> Product
    func getFavoriteStatus() -> Bool
}

final class ProductDetailViewModelImpl: ProductDetailViewModel {
    private var useCase: ProductDetailUseCase?
    
    var product: Product
    private var isFavorite: Bool = false
    
    init(useCase: ProductDetailUseCase, product: Product) {
        self.useCase = useCase
        self.product = product
        self.isFavorite = useCase.isFavorite(product)
    }

    func updateFavorite() {
        isFavorite ? useCase?.removeFavorite(product) : useCase?.addFavorite(product)
        isFavorite.toggle()
    }
    
    func getProduct() -> Product {
        return product
    }
    
    func getFavoriteStatus() -> Bool {
        return isFavorite
    }
}
