//
//  ProductListViewController.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 23.02.2024.
//

import UIKit
import RxSwift
import RxCocoa

class ProductListViewController: UIViewController, UITableViewDelegate {

    private var pr: ProductListUIElementsProvider?
    private var vm: ProductListViewModel?
    private let bag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        guard let pr = pr, let vm = vm else { return }
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = ""
        
        addObservationListener()
        pr.addSubviews(targetView: self.view)
        pr.addConstraints(targetView: self.view)
        
        pr.tableView.rx.setDelegate(self).disposed(by: bag)
        
        vm.productList.bind(to: pr.tableView.rx.items(cellIdentifier: "ProductTableViewCell", cellType: ProductTableViewCell.self)) { (row, item, cell) in
            cell.configureCell(item)
        }.disposed(by: bag)
        
        pr.tableView.rx.modelSelected(Product.self).subscribe(onNext: { item in
            print(item)
        }).disposed(by: bag)
        vm.getProductList()
    }
}

extension ProductListViewController {
    private func vmEventHandler(_ event: ProductListViewModelImpl.UserActivity?) {
        guard let event = event else { return }
        switch event {
        case .showSearchResults(let model):
            print(model)
        }
    }
    
    private func prEventHandler(_ event: ProductListUIElementsProviderImpl.UserActivity?) {
        guard let event = event else { return }
        switch event {
        case .search(let query):
            print(query)
        case .productSelected(let product):
            print(product)
        }
    }
    
    private func handleVMErrors(_ error: NetworkError) {
        switch error {
        default: AlertManager.showError(title: "Error", message: "An error occured", controller: self)
        }
    }
    
    private func handlePRErrors(_ error: Error) {
        AlertManager.showError(title: "Error", message: error.localizedDescription, controller: self)
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
            case .action(let data):
                self?.vmEventHandler(data)
            case .error(let error):
                guard let error else { return }
                self?.handleVMErrors(error)
            }
        }
        
        pr?.stateClosure = { [weak self] event in
            switch event {
            case .action(let data):
                self?.prEventHandler(data)
            case .error(let error):
                guard let error else { return }
                self?.handlePRErrors(error)
            }
        }
    }
}
