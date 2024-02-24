//
//  CartUseCase.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation
import RxSwift
import RxCocoa

protocol CartUseCase {
    func getCart() -> Observable<[Product: Int]>
    func removeCart(_ product: Product)
    func increaseQuantity(of product: Product)
    func decreaseQuantity(of product: Product)
    func getTotalPrice() -> Observable<Double>
    func getTotalDiscount() -> Observable<Double>
}

struct CartUseCaseImpl: CartUseCase {
    let cartManager: CartManager
    
    init(cartManager: CartManager) {
        self.cartManager = cartManager
    }
    
    func getCart() -> Observable<[Product: Int]> {
        return cartManager.cart
    }
    
    func removeCart(_ product: Product) {
        cartManager.removeProduct(product)
    }
    
    func increaseQuantity(of product: Product) {
        cartManager.increaseQuantity(of: product)
    }
    
    func decreaseQuantity(of product: Product) {
        cartManager.decreaseQuantity(of: product)
    }
    
    func getTotalPrice() -> Observable<Double> {
        return cartManager.totalCartPrice()
    }
    
    func getTotalDiscount() -> Observable<Double> {
        return cartManager.totalCartDiscount()
    }
}
