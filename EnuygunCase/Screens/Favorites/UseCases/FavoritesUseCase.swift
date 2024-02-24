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
    let favoritesManager: FavoritesManager
    
    init(favoritesManager: FavoritesManager) {
        self.favoritesManager = favoritesManager
    }
    
    func getFavorites() -> Observable<[Product]> {
        return favoritesManager.favoritesObservable()
    }
}
