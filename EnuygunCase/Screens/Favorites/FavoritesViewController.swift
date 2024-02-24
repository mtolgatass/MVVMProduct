//
//  FavoritesViewController.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesViewController: UIViewController {
    
    private var pr: FavoritesUIElementsProvider?
    private var vm: FavoritesViewModel?
    private let bag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Favorites"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        pr?.addSubviews(targetView: self.view)
        pr?.addConstraints(targetView: self.view)
        
        bindUIProvider()
        bindViewModel()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        title = ""
    }
    
    private func bindViewModel() {
        guard let pr = pr, let vm = vm else { return }
        
        vm.getFavorites().bind(to: pr.tableView.rx.items(cellIdentifier: "ProductTableViewCell", cellType: ProductTableViewCell.self)) { (row, item, cell) in
            cell.configureCell(item)
        }.disposed(by: bag)
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

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension FavoritesViewController {
    func inject(pr: FavoritesUIElementsProvider, vm: FavoritesViewModel) {
        self.pr = pr
        self.vm = vm
    }
}
