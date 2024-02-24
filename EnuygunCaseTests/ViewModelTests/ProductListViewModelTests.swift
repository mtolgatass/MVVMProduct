//
//  ProductListViewModelTests.swift
//  EnuygunCaseTests
//
//  Created by Tolga Taş on 25.02.2024.
//

import XCTest
import RxSwift
import RxTest
@testable import EnuygunCase

class ProductListViewModelTests: XCTestCase {
    
    let testProduct1 = Product(id: 1, title: "Test", description: "", price: 200, discountPercentage: 10, rating: 8.9, stock: 4, brand: "", category: "", thumbnail: URL(fileURLWithPath: ""), images: [])
    let testProduct2 = Product(id: 2, title: "Test2", description: "", price: 100, discountPercentage: 5, rating: 8.9, stock: 4, brand: "", category: "", thumbnail: URL(fileURLWithPath: ""), images: [])
    let testProduct3 = Product(id: 2, title: "Apple Macbook", description: "", price: 100, discountPercentage: 5, rating: 8.9, stock: 4, brand: "", category: "", thumbnail: URL(fileURLWithPath: ""), images: [])

    var sut: ProductListViewModelImpl!
    var productListUseCaseMock: ProductListUseCaseMock!
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!

    override func setUp() {
        super.setUp()
        productListUseCaseMock = ProductListUseCaseMock()
        sut = ProductListViewModelImpl(productListUseCase: productListUseCaseMock)
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        sut = nil
        productListUseCaseMock = nil
        disposeBag = nil
        scheduler = nil
        super.tearDown()
    }

    func testGetProductList() {
        // Given
        let expectedProducts = [testProduct1, testProduct2]
        productListUseCaseMock.getProductListResult = .success(ProductListResponseModel(products: expectedProducts, total: 2))

        // When
        sut.getProductList()

        // Then
        XCTAssertEqual(sut.productList.value, expectedProducts)
        XCTAssertEqual(sut.initialProductList.value, expectedProducts)
    }

    func testSearchTextDidChange() {
        // Given
        let searchText = "Apple"
        let expectedSearchResults = [testProduct3]
        productListUseCaseMock.searchProductResult = .success(ProductSearchResponseModel(products: expectedSearchResults, total: 1))

        // When
        sut.searchTextDidChange(searchText)

        // Then
        XCTAssertEqual(sut.productList.value, expectedSearchResults)
    }

    func testResetProductList() {
        // Given
        let initialProducts = [testProduct1, testProduct2]
        sut.initialProductList.accept(initialProducts)

        // When
        sut.resetProductList()

        // Then
        XCTAssertEqual(sut.productList.value, initialProducts)
    }
}
