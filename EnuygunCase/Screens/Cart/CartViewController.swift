//
//  CartViewController.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import UIKit
import RxSwift
import RxCocoa

class CartViewController: UIViewController {
    
    private var pr: CartUIElementsProvider?
    private var vm: CartViewModel?
    private let bag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Cart"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        pr?.addSubviews(targetView: self.view)
        pr?.addConstraints(targetView: self.view)
        
        bindUIProvider()
        bindViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }
    
    private func bindViewModel() {
        guard let pr = pr, let vm = vm else { return }
        
        vm.getCartItems().bind(to: pr.tableView.rx
            .items(cellIdentifier: "CartTableViewCell", cellType: CartTableViewCell.self)) { (row, item, cell) in
            cell.increaseButton.rx
                    .tap
                    .subscribe(onNext: { _ in
                vm.increaseQuantity(of: item.key)
            }).disposed(by: cell.bag)
            
            cell.decreaseButton.rx
                .tap
                .subscribe(onNext: { _ in
                vm.decreaseQuantity(of: item.key)
            }).disposed(by: cell.bag)
            
            cell.removeButton.rx
                .tap
                .subscribe(onNext: { _ in
                vm.removeCart(item.key)
            }).disposed(by: cell.bag)
            
            cell.configureCell(item.key, item.value)
        }.disposed(by: bag)
        
        vm.getTotalPrice()
            .subscribe(onNext: { price in
            pr.priceLabel.text = "Total Price: \(Int(price))₺"
        }).disposed(by: bag)
        
        vm.getTotalDiscount()
            .subscribe(onNext: { price in
            pr.discountedPriceLabel.text = "Discount: \(Int(price))₺"
        }).disposed(by: bag)
        
        Observable.combineLatest(vm.getTotalPrice(), vm.getTotalDiscount())
            .subscribe(onNext: { price, discount in
            pr.totalPriceLabel.text = "Total Price: \(Int(price - discount))₺"
        }).disposed(by: bag)
    }
    
    private func bindUIProvider() {
        guard let pr = pr else { return }
        pr.tableView.rx.setDelegate(self).disposed(by: bag)
        
        pr.tableView.rx.modelSelected(Product.self).subscribe(onNext: { item in
            let productDetailVC = ProductDetailBuilderImpl().build(product: item)
            self.present(productDetailVC, animated: true)
        }).disposed(by: bag)
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension CartViewController {
    func inject(pr: CartUIElementsProvider, vm: CartViewModel) {
        self.pr = pr
        self.vm = vm
    }
}