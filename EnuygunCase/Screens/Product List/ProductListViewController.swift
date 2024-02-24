//
//  ProductListViewController.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 23.02.2024.
//

import UIKit
import RxSwift
import RxCocoa

class ProductListViewController: UIViewController {
    
    private var pr: ProductListUIElementsProvider?
    private var vm: ProductListViewModel?
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = ""
        
        addObservationListener()
        pr?.addSubviews(targetView: self.view)
        pr?.addConstraints(targetView: self.view)
        bindUIProvider()
        bindViewModel()
        
        vm?.getProductList()
    }
    
    private func bindViewModel() {
        guard let pr = pr, let vm = vm else { return }
        vm.productList
            .map { $0.count }
            .map { "(\($0) adet)" }
            .bind(to: pr.productCountLabel.rx.text)
            .disposed(by: bag)
        
        vm.productList.bind(to: pr.tableView.rx.items(cellIdentifier: "ProductTableViewCell", cellType: ProductTableViewCell.self)) { (row, item, cell) in
            cell.configureCell(item)
        }.disposed(by: bag)
    }
    
    private func bindUIProvider() {
        guard let pr = pr, let vm = vm else { return }
        pr.tableView.rx.setDelegate(self).disposed(by: bag)
        
        pr.tableView.rx.modelSelected(Product.self).subscribe(onNext: { item in
            let productDetailVC = ProductDetailBuilderImpl().build(product: item)
            self.present(productDetailVC, animated: true)
        }).disposed(by: bag)
        
        pr.searchBar.rx.text
            .orEmpty
            .subscribe(onNext: { query in
                vm.searchTextDidChange(query)
            }).disposed(by: bag)
    }
}

extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ProductListViewController {
    private func handleVMErrors(_ error: NetworkError) {
        switch error {
        default: AlertManager.showError(title: "Error", message: "An error occured", controller: self)
        }
    }
}

extension ProductListViewController {
    func inject(pr: ProductListUIElementsProvider, vm: ProductListViewModel) {
        self.pr = pr
        self.vm = vm
    }
    
    func addObservationListener() {
        vm?.stateClosure = { [weak self] event in
            switch event {
            case .error(let error):
                guard let error else { return }
                self?.handleVMErrors(error)
            }
        }
    }
}
