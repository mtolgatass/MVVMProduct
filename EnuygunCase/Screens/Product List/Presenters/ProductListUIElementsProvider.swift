//
//  ProductListUIElementsProvider.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 23.02.2024.
//

import UIKit
import SnapKit

protocol ProductListUIElementsProvider {
    var tableView: UITableView { get }
    var productCountLabel: UILabel { get }
    var searchBar: UISearchBar { get }
    func addSubviews(targetView: UIView)
    func addConstraints(targetView: UIView)
}

final class ProductListUIElementsProviderImpl: NSObject, ProductListUIElementsProvider {
    private var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private var labelContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 4
        return stack
    }()
    
    private var productsLabel: UILabel = {
        let label = UILabel()
        label.text = "Products"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        return label
    }()
    
    var productCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .lightGray
        return label
    }()
    
    private var emptyView: UIView = {
        let view = UIView()
        return view
    }()
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Product"
        return searchBar
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        return tableView
    }()
    
    func addSubviews(targetView: UIView) {
        targetView.addSubview(containerStack)
        containerStack.addArrangedSubview(labelContainerStack)
        containerStack.addArrangedSubview(searchBar)
        containerStack.addArrangedSubview(tableView)
        
        labelContainerStack.addArrangedSubview(productsLabel)
        labelContainerStack.addArrangedSubview(productCountLabel)
        labelContainerStack.addArrangedSubview(emptyView)
    }
    
    func addConstraints(targetView: UIView) {
        containerStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalTo(targetView.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(targetView.safeAreaLayoutGuide.snp.bottom)
        }
        
        searchBar.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        tableView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.85)
        }
    }
}
