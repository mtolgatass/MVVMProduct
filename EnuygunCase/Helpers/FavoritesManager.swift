//
//  FavoritesManager.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation
import RxSwift

class FavoritesManager {
    static let shared = FavoritesManager()
    
    private let favoritesKey = "favorites"
    private let favoritesSubject = BehaviorSubject<[Product]>(value: [])
    
    private init() {
        loadFavorites()
    }
    
    func addFavorite(_ product: Product) {
        var favorites = currentFavorites()
        if !favorites.contains(product) {
            favorites.append(product)
            saveFavorites(favorites)
        }
    }
    
    func removeFavorite(_ product: Product) {
        var favorites = currentFavorites()
        if let index = favorites.firstIndex(of: product) {
            favorites.remove(at: index)
            saveFavorites(favorites)
        }
    }
    
    func isFavorite(_ product: Product) -> Bool {
        let favorites = currentFavorites()
        return favorites.contains(product)
    }
    
    func favoritesObservable() -> Observable<[Product]> {
        return favoritesSubject.asObservable()
    }
    
    private func currentFavorites() -> [Product] {
        do {
            if let favoritesData = UserDefaults.standard.data(forKey: favoritesKey) {
                let favorites = try JSONDecoder().decode([Product].self, from: favoritesData)
                return favorites
            }
        } catch {
            print("Error decoding favorites: \(error.localizedDescription)")
        }
        return []
    }
    
    private func saveFavorites(_ favorites: [Product]) {
        do {
            let favoritesData = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(favoritesData, forKey: favoritesKey)
            favoritesSubject.onNext(favorites)
        } catch {
            print("Error encoding favorites: \(error.localizedDescription)")
        }
    }
    
    private func loadFavorites() {
        let favorites = currentFavorites()
        favoritesSubject.onNext(favorites)
    }
}
