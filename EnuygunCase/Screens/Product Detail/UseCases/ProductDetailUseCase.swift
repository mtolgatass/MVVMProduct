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
//    func addToCart()
}

struct ProductDetailUseCaseImpl: ProductDetailUseCase {
    let userDefaultsManager: UserDefaultsManager
    
    init(userDefaultsManager: UserDefaultsManager) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    func addFavorite(_ product: Product) {
        userDefaultsManager.addFavorite(product)
    }
    
    func removeFavorite(_ product: Product) {
        userDefaultsManager.removeFavorite(product)
    }
    
    func isFavorite(_ product: Product) -> Bool {
        return userDefaultsManager.isFavorite(product)
    }
    
//    func addToCart() {}
}
