//
//  ProductListViewModel.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 23.02.2024.
//

import Foundation
import RxSwift
import RxRelay

protocol ProductListViewModel {
    var stateClosure: ((ObservationType<NetworkError>) -> ())? { get set }
    var productList: BehaviorRelay<[Product]> { get }
    var initialProductList: BehaviorRelay<[Product]> { get }
    var searchActive: BehaviorRelay<Bool> { get }
    func getProductList()
    func searchTextDidChange(_ query: String)
    func resetProductList()
    func filterProductList(_ filterType: ProductListFilterType)
    func sortProductList(_ sortType: ProductListSortType)
}

final class ProductListViewModelImpl: ProductListViewModel {
    var stateClosure: ((ObservationType<NetworkError>) -> ())?
    let productListUseCase: ProductListUseCase
    
    let productList = BehaviorRelay<[Product]>(value: [])
    let initialProductList = BehaviorRelay<[Product]>(value: [])
    private let searchResults = BehaviorRelay<[Product]>(value: [])
    
    private let disposeBag = DisposeBag()
    private let searchThrottle = PublishSubject<String>()
    
    var searchActive = BehaviorRelay<Bool>(value: false)
    
    init(productListUseCase: ProductListUseCase) {
        self.productListUseCase = productListUseCase
        setupSearch()
    }
    
    func getProductList() {
        productListUseCase.getProductList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let initialList = response.products
                initialProductList.accept(initialList)
                productList.accept(initialList)
            case .failure(let error):
                stateClosure?(.error(error: error))
            }
        }
    }
    
    func searchTextDidChange(_ query: String) {
        searchThrottle.onNext(query)
    }
    
    private func setupSearch() {
        searchThrottle
            .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] query in
                guard let self = self else { return }
                if query.count < 3 {
                    self.searchActive.accept(false)
                    self.resetProductList()
                } else {
                    self.searchActive.accept(true)
                    self.searchProduct(query)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func searchProduct(_ query: String) {
        productListUseCase.searchProduct(query) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let searchResults = response.products
                self.searchResults.accept(searchResults)
                productList.accept(searchResults)
            case .failure(let error):
                stateClosure?(.error(error: error))
            }
        }
    }
    
    func resetProductList() {
        productList.accept(initialProductList.value)
    }
    
    func resetSearchResult() {
        productList.accept(searchResults.value)
    }
    
    func filterProductList(_ filterType: ProductListFilterType) {
        searchActive.value ?
        resetSearchResult() :
        resetProductList()
        
        switch filterType {
        case .priceRange(let min, let max):
            let filteredList = productList.value.filter { $0.price >= min && $0.price <= max }
            productList.accept(filteredList)
        }
    }
    
    func sortProductList(_ sortType: ProductListSortType) {
        searchActive.value ?
        resetSearchResult() :
        resetProductList()
        switch sortType {
        case .priceAsc:
            let sortedList = productList.value.sorted { $0.price < $1.price }
            productList.accept(sortedList)
        case .priceDesc:
            let sortedList = productList.value.sorted { $0.price > $1.price }
            productList.accept(sortedList)
        case .titleAsc:
            let sortedList = productList.value.sorted { $0.title < $1.title }
            productList.accept(sortedList)
        case .titleDesc:
            let sortedList = productList.value.sorted { $0.title > $1.title }
            productList.accept(sortedList)
        }
    }
}
