//
//  ProductDetailUseCase.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation

protocol ProductDetailUseCase {
    func addFavorite(_ product: Product)
    func removeFavorite(_ product: Product)
    func isFavorite(_ product: Product) -> Bool
    func addToCart(_ product: Product)
}

struct ProductDetailUseCaseImpl: ProductDetailUseCase {
    let favoritesManager: FavoritesManager
    let cartManager: CartManager
    
    init(favoritesManager: FavoritesManager, cartManager: CartManager) {
        self.favoritesManager = favoritesManager
        self.cartManager = cartManager
    }
    
    func addFavorite(_ product: Product) {
        favoritesManager.addFavorite(product)
    }
    
    func removeFavorite(_ product: Product) {
        favoritesManager.removeFavorite(product)
    }
    
    func isFavorite(_ product: Product) -> Bool {
        return favoritesManager.isFavorite(product)
    }
    
    func addToCart(_ product: Product) {
        cartManager.addProduct(product)
    }
}
