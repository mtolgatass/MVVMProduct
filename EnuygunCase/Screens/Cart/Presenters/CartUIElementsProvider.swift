//
//  CartUIElementsProvider.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation
import UIKit
import SnapKit

protocol CartUIElementsProvider {
    var tableView: UITableView { get }
    var priceLabel: UILabel { get }
    var discountedPriceLabel: UILabel { get }
    var totalPriceLabel: UILabel { get }
    var checkoutButton: UIButton { get }
    func addSubviews(targetView: UIView)
    func addConstraints(targetView: UIView)
    func disableCheckoutButton()
    func enableCheckoutButton()
    func hidePriceLabels()
    func showPriceLabels()
}

final class CartUIElementsProviderImpl: CartUIElementsProvider {
    private var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private var favoritesLabel: UILabel = {
        let label = UILabel()
        label.text = "Cart"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        return label
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
        return tableView
    }()
    
    private var priceContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price:"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    var discountedPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "Discount:"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .systemRed
        label.textAlignment = .right
        return label
    }()
    
    var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "Total:"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    var checkoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Checkout", for: .normal)
        button.setTitle("Add Items to Checkout", for: .disabled)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    
    func addSubviews(targetView: UIView) {
        targetView.addSubview(containerStack)
        containerStack.addArrangedSubview(favoritesLabel)
        containerStack.addArrangedSubview(tableView)
        containerStack.addArrangedSubview(priceContainerStack)
        containerStack.addArrangedSubview(checkoutButton)
        
        priceContainerStack.addArrangedSubview(priceLabel)
        priceContainerStack.addArrangedSubview(discountedPriceLabel)
        priceContainerStack.addArrangedSubview(totalPriceLabel)
    }
    
    func addConstraints(targetView: UIView) {
        containerStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalTo(targetView.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(targetView.safeAreaLayoutGuide.snp.bottom)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        discountedPriceLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        discountedPriceLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        checkoutButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
    func disableCheckoutButton() {
        checkoutButton.isEnabled = false
    }
    
    func enableCheckoutButton() {
        checkoutButton.isEnabled = true
    }
    
    func hidePriceLabels() {
        priceContainerStack.isHidden = true
    }
    
    func showPriceLabels() {
        priceContainerStack.isHidden = false
    }
}
