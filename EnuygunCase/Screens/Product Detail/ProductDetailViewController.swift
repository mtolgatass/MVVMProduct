//
//  ProductDetailViewController.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import UIKit
import RxSwift
import RxCocoa

class ProductDetailViewController: UIViewController {
    
    private var pr: ProductDetailUIElementsProvider?
    private var vm: ProductDetailViewModel?
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        pr?.addSubviews(targetView: self.view)
        pr?.addConstraints(targetView: self.view)
        
        guard let vm = vm else { return }
        pr?.configureUI(product: vm.getProduct(), isFavorite: vm.getFavoriteStatus())
        bindGestures()
    }
    
    private func bindGestures() {
        guard let pr = pr, let vm = vm else { return }
        pr.favoriteButton.rx.tap.bind {
            vm.updateFavorite()
            pr.setFavoriteButton(isFavorite: vm.getFavoriteStatus())
        }.disposed(by: bag)
        
        pr.cartButton.rx.tap.bind {
            vm.addProductToCart()
            pr.updateCartButton()
        }.disposed(by: bag)
    }
}
extension ProductDetailViewController {
    func inject(pr: ProductDetailUIElementsProvider, vm: ProductDetailViewModel) {
        self.pr = pr
        self.vm = vm
    }
}
