//
//  ProductDetailUIElementsProvider.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation
import UIKit
import SnapKit

protocol ProductDetailUIElementsProvider {
    func addSubviews(targetView: UIView)
    func addConstraints(targetView: UIView)
    func configureUI(product: Product, isFavorite: Bool)
    func setFavoriteButton(isFavorite: Bool)
    func updateCartButton()
    var favoriteButton: UIButton { get }
    var cartButton: UIButton { get }
}

final class ProductDetailUIElementsProviderImpl: ProductDetailUIElementsProvider {
    
    private var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private var imageContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var productTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private var productPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private var productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var emptyView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var buttonContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    var cartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 8
        return button
    }()
    
    var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favoriteIconEmpty"), for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 8
        return button
    }()
    
    private var discountCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        view.layer.cornerRadius = 36
        return view
    }()
    
    private var discountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    func addSubviews(targetView: UIView) {
        targetView.addSubview(containerStack)
        containerStack.addArrangedSubview(imageContainerView)
        containerStack.addArrangedSubview(productPriceLabel)
        containerStack.addArrangedSubview(productTitleLabel)
        containerStack.addArrangedSubview(productDescriptionLabel)
        containerStack.addArrangedSubview(emptyView)
        
        imageContainerView.addSubview(productImageView)
        imageContainerView.addSubview(discountCircle)
        discountCircle.addSubview(discountLabel)
        
        targetView.addSubview(buttonContainer)
        buttonContainer.addArrangedSubview(cartButton)
        buttonContainer.addArrangedSubview(favoriteButton)
    }
    
    func addConstraints(targetView: UIView) {
        containerStack.snp.makeConstraints { make in
            make.top.equalTo(targetView.safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(targetView.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        
        imageContainerView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        productImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        discountCircle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.height.width.equalTo(72)
        }
        
        discountLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        buttonContainer.snp.makeConstraints { make in
            make.bottom.equalTo(targetView.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        cartButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    func configureUI(product: Product, isFavorite: Bool) {
        productImageView.loadImage(from: product.images.first ?? URL(fileURLWithPath: ""))
        productTitleLabel.text = product.title
        productPriceLabel.text = "\(product.price) TL"
        productDescriptionLabel.text = product.description
        if product.discountPercentage != 0 {
            discountLabel.text = "-\(Int(product.discountPercentage))%"
        } else {
            discountCircle.isHidden = true
        }
        
        if isFavorite {
            favoriteButton.setImage(UIImage(named: "favoriteIconFilled"), for: .normal)
        }
    }
    
    func setFavoriteButton(isFavorite: Bool) {
        favoriteButton.setImage(UIImage(named: isFavorite ? "favoriteIconFilled" : "favoriteIconEmpty"), for: .normal)
    }
    
    func updateCartButton() {
        cartButton.setTitle("Added to Cart", for: .normal)
        cartButton.backgroundColor = .systemGreen
    }
}
