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
    var stateClosure: ((ObservationType<ProductListViewModelImpl.UserActivity, NetworkError>) -> ())? { get set }
    var productList: PublishSubject<[Product]> { get }
    func getProductList()
    func searchProduct(_ query: String)
}

final class ProductListViewModelImpl: ProductListViewModel {
    var stateClosure: ((ObservationType<ProductListViewModelImpl.UserActivity, NetworkError>) -> ())?
    let productListUseCase: ProductListUseCase
    
    let productList = PublishSubject<[Product]>()
    
    init(productListUseCase: ProductListUseCase) {
        self.productListUseCase = productListUseCase
    }
    
    func getProductList() {
        productListUseCase.getProductList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                productList.onNext(response.products)
                productList.onCompleted()
            case .failure(let error):
                stateClosure?(.error(error: error))
            }
        }
    }
    
    func searchProduct(_ query: String) {
        productListUseCase.searchProduct(query) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                stateClosure?(.action(data: .showSearchResults(response.products)))
            case .failure(let error):
                stateClosure?(.error(error: error))
            }
        }
    }
}

// MARK: - User Activity Extension
extension ProductListViewModelImpl {
    enum UserActivity {
        case showSearchResults(_ model: [Product])
    }
}
