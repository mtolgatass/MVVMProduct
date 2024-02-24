//
//  FavoritesViewModel.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation
import RxSwift

protocol FavoritesViewModel {
    func getFavorites() -> Observable<[Product]>
}

final class FavoritesViewModelImpl: FavoritesViewModel {
    private let favoritesUseCase: FavoritesUseCase?
    private var favorites: Observable<[Product]>
    
    init(favoritesUseCase: FavoritesUseCase) {
        self.favoritesUseCase = favoritesUseCase
        favorites = favoritesUseCase.getFavorites()
    }
    
    func getFavorites() -> Observable<[Product]> {
        return favorites
    }
}
