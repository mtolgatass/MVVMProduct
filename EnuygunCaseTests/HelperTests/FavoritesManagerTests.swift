//
//  FavoritesManagerTests.swift
//  EnuygunCaseTests
//
//  Created by Tolga Taş on 25.02.2024.
//

import XCTest
import RxSwift
import RxTest
@testable import EnuygunCase

class FavoritesManagerTests: XCTestCase {

    var favoritesManager: FavoritesManager!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        favoritesManager = FavoritesManager.shared
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        favoritesManager = nil
        disposeBag = nil
        super.tearDown()
    }

    func testAddFavorite() {
        // Given
        let productToAdd = Product(id: 1, title: "Test Product 1", description: "Description 1", price: 100, discountPercentage: 0, rating: 4.5, stock: 100, brand: "Brand 1", category: "Category 1", thumbnail: URL(string: "https://example.com")!, images: [])

        // When
        favoritesManager.addFavorite(productToAdd)

        // Then
        XCTAssertTrue(favoritesManager.isFavorite(productToAdd))
    }

    func testRemoveFavorite() {
        // Given
        let productToRemove = Product(id: 2, title: "Test Product 2", description: "Description 2", price: 200, discountPercentage: 0, rating: 4.0, stock: 50, brand: "Brand 2", category: "Category 2", thumbnail: URL(string: "https://example.com")!, images: [])
        favoritesManager.addFavorite(productToRemove)

        // When
        favoritesManager.removeFavorite(productToRemove)

        // Then
        XCTAssertFalse(favoritesManager.isFavorite(productToRemove))
    }

    func testFavoritesObservable() {
        // Given
        let product1 = Product(id: 1, title: "Test Product 1", description: "Description 1", price: 100, discountPercentage: 0, rating: 4.5, stock: 100, brand: "Brand 1", category: "Category 1", thumbnail: URL(string: "https://example.com")!, images: [])
        let product2 = Product(id: 2, title: "Test Product 2", description: "Description 2", price: 200, discountPercentage: 0, rating: 4.0, stock: 50, brand: "Brand 2", category: "Category 2", thumbnail: URL(string: "https://example.com")!, images: [])

        let expectation = XCTestExpectation(description: "Favorites observable emitted values")

        favoritesManager.resetFavorites()
        // When
        favoritesManager.favoritesObservable()
            .subscribe(onNext: { products in
                if products.count == 2 && products.contains(product1) && products.contains(product2) {
                    expectation.fulfill()
                }
            })
            .disposed(by: disposeBag)

        // Then
        favoritesManager.addFavorite(product1)
        favoritesManager.addFavorite(product2)

        wait(for: [expectation], timeout: 1)
    }
}
