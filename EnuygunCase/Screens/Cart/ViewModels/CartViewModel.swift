//
//  CartViewModel.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation
import RxSwift

protocol CartViewModel {
    func getCartItems() -> Observable<[Product: Int]>
    func getTotalPrice() -> Observable<Double>
    func getTotalDiscount() -> Observable<Double>
    func removeCart(_ product: Product)
    func increaseQuantity(of product: Product)
    func decreaseQuantity(of product: Product)
}

final class CartViewModelImpl: CartViewModel {
    private let cartUseCase: CartUseCase
    private var cartItems: Observable<[Product: Int]>
    
    init(cartUseCase: CartUseCase) {
        self.cartUseCase = cartUseCase
        cartItems = cartUseCase.getCart()
    }
    
    func getCartItems() -> Observable<[Product: Int]> {
        return cartItems
    }
    
    func getTotalPrice() -> Observable<Double> {
        return cartUseCase.getTotalPrice()
    }
    
    func getTotalDiscount() -> Observable<Double> {
        return cartUseCase.getTotalDiscount()
    }
    
    func removeCart(_ product: Product) {
        cartUseCase.removeCart(product)
    }
    
    func increaseQuantity(of product: Product) {
        cartUseCase.increaseQuantity(of: product)
    }
    
    func decreaseQuantity(of product: Product) {
        cartUseCase.decreaseQuantity(of: product)
    }
}
