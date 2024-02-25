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
    var filterButton: UIButton { get }
    var sortButton: UIButton { get }
    func addSubviews(targetView: UIView)
    func addConstraints(targetView: UIView)
    func setFilterState(isActive: Bool)
    func setSortState(isActive: Bool)
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
    
    private var searchContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Product"
        return searchBar
    }()
    
    var filterButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.tinted()
        let image = UIImage(named: "FilterIcon")
        buttonConfiguration.image = image
        let button = UIButton(configuration: buttonConfiguration)
        button.tintColor = .systemGray
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.cornerRadius = 8
        return button
    }()
    
    var sortButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.tinted()
        let image = UIImage(named: "SortIcon")
        buttonConfiguration.image = image
        let button = UIButton(configuration: buttonConfiguration)
        button.tintColor = .systemGray
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.cornerRadius = 8
        return button
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
        containerStack.addArrangedSubview(searchContainerStack)
        containerStack.addArrangedSubview(tableView)
        
        searchContainerStack.addArrangedSubview(searchBar)
        searchContainerStack.addArrangedSubview(filterButton)
        searchContainerStack.addArrangedSubview(sortButton)
        
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
        
        searchContainerStack.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        filterButton.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
        
        sortButton.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.85)
        }
    }
    
    func setFilterState(isActive: Bool) {
        let color = isActive ? UIColor.systemBlue : UIColor.systemGray
        filterButton.tintColor = color
    }
    
    func setSortState(isActive: Bool) {
        let color = isActive ? UIColor.systemBlue : UIColor.systemGray
        sortButton.tintColor = color
    }
}
