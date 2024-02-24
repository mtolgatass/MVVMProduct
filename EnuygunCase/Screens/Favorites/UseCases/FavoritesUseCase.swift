//
//  FavoritesUseCase.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation
import RxSwift

protocol FavoritesUseCase {
    func getFavorites() -> Observable<[Product]>
}

struct FavoritesUseCaseImpl: FavoritesUseCase {
    let userDefaultsManager: UserDefaultsManager
    
    init(userDefaultsManager: UserDefaultsManager) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    func getFavorites() -> Observable<[Product]> {
        return userDefaultsManager.favoritesObservable()
    }
}
