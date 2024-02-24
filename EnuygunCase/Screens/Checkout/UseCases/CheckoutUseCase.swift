//
//  CheckoutUseCase.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation

protocol CheckoutUseCase {
    func emptyCart()
}

struct CheckoutUseCaseImpl: CheckoutUseCase {
    let cartManager: CartManager
    
    init(cartManager: CartManager) {
        self.cartManager = cartManager
    }
    
    func emptyCart() {
        cartManager.removeAll()
    }
}
