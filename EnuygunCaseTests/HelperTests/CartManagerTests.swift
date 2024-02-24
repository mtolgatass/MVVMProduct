//
//  CartManagerTests.swift
//  EnuygunCaseTests
//
//  Created by Tolga Taş on 25.02.2024.
//

import XCTest
import RxSwift
@testable import EnuygunCase

final class CartManagerTests: XCTestCase {

    var sut: CartManager!
    var disposeBag: DisposeBag!
    
    let testProduct = Product(id: 1, title: "", description: "", price: 200, discountPercentage: 10, rating: 8.9, stock: 4, brand: "", category: "", thumbnail: URL(fileURLWithPath: ""), images: [])
    let testProduc2 = Product(id: 2, title: "", description: "", price: 100, discountPercentage: 5, rating: 8.9, stock: 4, brand: "", category: "", thumbnail: URL(fileURLWithPath: ""), images: [])
    
    override func setUp() {
        super.setUp()
        sut = CartManager.shared
        sut.removeAll()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testAddToCart() {
        sut.addProduct(testProduct)
        XCTAssertEqual(sut.cartSubject.value[testProduct], 1)
    }
    
    func testRemoveFromCart() {
        sut.addProduct(testProduct)
        sut.removeProduct(testProduct)
        XCTAssertNil(sut.cartSubject.value[testProduct])
    }
    
    func testIncreaseQuantity() {
        sut.addProduct(testProduct)
        sut.increaseQuantity(of: testProduct)
        XCTAssertEqual(sut.cartSubject.value[testProduct], 2)
    }
    
    func testDecreaseQuantity() {
        sut.addProduct(testProduct)
        sut.increaseQuantity(of: testProduct)
        sut.increaseQuantity(of: testProduct)
        sut.decreaseQuantity(of: testProduct)
        XCTAssertEqual(sut.cartSubject.value[testProduct], 2)
    }
    
    func testDecreaseQuantityWhenQuantityIsOne() {
        sut.addProduct(testProduct)
        sut.decreaseQuantity(of: testProduct)
        XCTAssertNil(sut.cartSubject.value[testProduct])
    }
    
    func testTotalPrice() {
        sut.addProduct(testProduct)
        sut.addProduct(testProduc2)
        
        var totalCartPrice: Double = 0.0
        sut.totalCartPrice()
            .subscribe(onNext: { price in
                totalCartPrice = price
            })
            .disposed(by: disposeBag)
        
        let expectedTotalPrice = Double(testProduct.price + testProduc2.price)
        
        XCTAssertEqual(totalCartPrice, expectedTotalPrice)
    }
    
    func testTotalCartDiscount() {
        sut.addProduct(testProduct)
        sut.addProduct(testProduc2)
        
        var totalCartDiscount: Double = 0.0
        sut.totalCartDiscount()
            .subscribe(onNext: { discount in
                totalCartDiscount = discount
            })
            .disposed(by: disposeBag)
        
        let expectedTotalDiscount = (Double(testProduct.price) * testProduct.discountPercentage / 100.0) + (Double(testProduc2.price) * testProduc2.discountPercentage / 100.0)
        
        XCTAssertEqual(totalCartDiscount, expectedTotalDiscount)
    }
}
