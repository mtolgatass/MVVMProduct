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
    func getProductList()
    func searchTextDidChange(_ query: String)
}

final class ProductListViewModelImpl: ProductListViewModel {
    var stateClosure: ((ObservationType<NetworkError>) -> ())?
    let productListUseCase: ProductListUseCase
    
    let productList = BehaviorRelay<[Product]>(value: [])
    let initialProductList = BehaviorRelay<[Product]>(value: [])
    
    private let disposeBag = DisposeBag()
    private let searchThrottle = PublishSubject<String>()
    
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
                    self.resetProductList()
                } else {
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
                productList.accept(searchResults)
            case .failure(let error):
                stateClosure?(.error(error: error))
            }
        }
    }
    
    func resetProductList() {
        productList.accept(initialProductList.value)
    }
}
