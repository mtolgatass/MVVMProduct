//
//  CartManager.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation
import RxSwift
import RxCocoa

class CartManager {
    static let shared = CartManager()
    
    private let cartKey = "cart"
    var cartSubject = BehaviorRelay<[Product: Int]>(value: [:])
    
    var cart: Observable<[Product: Int]> {
        return cartSubject.asObservable()
    }
    
    private init() {
        loadCartFromUserDefaults()
    }
    
    private func loadCartFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: cartKey),
           let cart = try? JSONDecoder().decode([Product: Int].self, from: data) {
            cartSubject.accept(cart)
        }
    }
    
    private func saveCartToUserDefaults() {
        do {
            let cartData = try JSONEncoder().encode(cartSubject.value)
            UserDefaults.standard.set(cartData, forKey: cartKey)
        } catch {
            print("Error encoding cart: \(error.localizedDescription)")
        }
    }
    
    func addProduct(_ product: Product) {
        var currentCart = cartSubject.value
        if let quantity = currentCart[product] {
            currentCart[product] = quantity + 1
        } else {
            currentCart[product] = 1
        }
        cartSubject.accept(currentCart)
        saveCartToUserDefaults()
    }
    
    func removeProduct(_ product: Product) {
        var currentCart = cartSubject.value
        currentCart.removeValue(forKey: product)
        cartSubject.accept(currentCart)
        saveCartToUserDefaults()
    }
    
    func increaseQuantity(of product: Product) {
        var currentCart = cartSubject.value
        if let quantity = currentCart[product] {
            currentCart[product] = quantity + 1
            cartSubject.accept(currentCart)
            saveCartToUserDefaults()
        }
    }
    
    func decreaseQuantity(of product: Product) {
        var currentCart = cartSubject.value
        if let quantity = currentCart[product], quantity > 1 {
            currentCart[product] = quantity - 1
            cartSubject.accept(currentCart)
            saveCartToUserDefaults()
        } else {
            currentCart.removeValue(forKey: product)
            cartSubject.accept(currentCart)
            saveCartToUserDefaults()
        }
    }
    
    func totalCartPrice() -> Observable<Double> {
        return cart.map { cart in
            var totalPrice: Double = 0.0
            for (product, quantity) in cart {
                totalPrice += Double(product.price) * Double(quantity)
            }
            return totalPrice
        }
    }
    
    func totalCartDiscount() -> Observable<Double> {
        return cart.map { cart in
            var totalDiscount: Double = 0.0
            for (product, quantity) in cart {
                let discount = Double(product.price) * product.discountPercentage / 100.0
                totalDiscount += discount * Double(quantity)
            }
            return totalDiscount
        }
    }
    
    func removeAll() {
        cartSubject.accept([:])
    }
}
