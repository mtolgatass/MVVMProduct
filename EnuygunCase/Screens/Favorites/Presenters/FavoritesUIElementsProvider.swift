//
//  FavoritesUIElementsProvider.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation
import UIKit
import SnapKit

protocol FavoritesUIElementsProvider {
    var tableView: UITableView { get }
    func addSubviews(targetView: UIView)
    func addConstraints(targetView: UIView)
}

final class FavoritesUIElementsProviderImpl: FavoritesUIElementsProvider {
    private var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private var favoritesLabel: UILabel = {
        let label = UILabel()
        label.text = "Favoriler"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        return label
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
        containerStack.addArrangedSubview(favoritesLabel)
        containerStack.addArrangedSubview(tableView)
    }
    
    func addConstraints(targetView: UIView) {
        containerStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalTo(targetView.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(targetView.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
