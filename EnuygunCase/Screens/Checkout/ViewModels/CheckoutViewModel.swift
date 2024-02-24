//
//  CheckoutViewModel.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation

protocol CheckoutViewModel {
    func emptyCart()
}

class CheckoutViewModelImpl: CheckoutViewModel {
    let checkoutUseCase: CheckoutUseCase
    
    init(checkoutUseCase: CheckoutUseCase) {
        self.checkoutUseCase = checkoutUseCase
    }
    
    func emptyCart() {
        checkoutUseCase.emptyCart()
    }
}
