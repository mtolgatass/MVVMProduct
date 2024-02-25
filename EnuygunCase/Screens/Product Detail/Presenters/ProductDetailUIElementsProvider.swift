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
    func configureScrollView(_ bannerInfo: [URL])
    func setFavoriteButton(isFavorite: Bool)
    func updateCartButton()
    var favoriteButton: UIButton { get }
    var cartButton: UIButton { get }
}

final class ProductDetailUIElementsProviderImpl: NSObject, ProductDetailUIElementsProvider {
    
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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.backgroundColor = .clear
        control.currentPageIndicatorTintColor = .systemGray
        control.isUserInteractionEnabled = false
        control.pageIndicatorTintColor = .white
        control.backgroundColor = .clear
        return control
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
        button.setImage(UIImage(named: "FavoriteIconEmpty"), for: .normal)
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
    
    private var bannerCount: Int = 0
    
    func addSubviews(targetView: UIView) {
        targetView.addSubview(containerStack)
        containerStack.addArrangedSubview(imageContainerView)
        containerStack.addArrangedSubview(productPriceLabel)
        containerStack.addArrangedSubview(productTitleLabel)
        containerStack.addArrangedSubview(productDescriptionLabel)
        containerStack.addArrangedSubview(emptyView)
        
        imageContainerView.addSubview(scrollView)
        imageContainerView.addSubview(pageControl)
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
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(30)
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
        configureScrollView(product.images)
        productTitleLabel.text = product.title
        productDescriptionLabel.text = product.description
        if product.discountPercentage != 0 {
            discountLabel.text = "-\(Int(product.discountPercentage))%"
            
            let discountedPrice = Double(product.price) - (Double(product.price) * product.discountPercentage / 100)
            
            let discountedAttributedString: NSMutableAttributedString =  NSMutableAttributedString(string: " \(Int(discountedPrice)) TL")
            discountedAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 16), range: NSMakeRange(0, discountedAttributedString.length))
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(product.price) TL")
            
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range: NSMakeRange(0, attributeString.length))
            attributeString.append(discountedAttributedString)
            productPriceLabel.attributedText = attributeString
        } else {
            productPriceLabel.text = "\(product.price) TL"
            discountCircle.isHidden = true
        }
        
        if isFavorite {
            favoriteButton.setImage(UIImage(named: "FavoriteIconFilled"), for: .normal)
        }
    }
    
    func configureScrollView(_ bannerInfo: [URL]) {
        guard !bannerInfo.isEmpty else {
            setupEmptyState()
            return
        }
        
        bannerCount = bannerInfo.count
        
        for x in 0..<bannerInfo.count {
            addBannerImageView(bannerInfo[x], at: CGFloat(x) * scrollView.frame.size.width)
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(bannerCount), height: scrollView.frame.size.height)
        scrollView.contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y)
        
        pageControl.numberOfPages = bannerCount
        pageControl.currentPage = 0
    }
    
    private func setupEmptyState() {
        let emptyImageView = UIImageView(frame: .zero)
        emptyImageView.image = UIImage(named: "")
        scrollView.addSubview(emptyImageView)
    }
    
    private func addBannerImageView(_ banner: URL, at positionX: CGFloat) {
        let bannerImageView = UIImageView(frame: CGRect(x: positionX, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
        bannerImageView.contentMode = .scaleAspectFit
        bannerImageView.loadImage(from: banner)
        scrollView.addSubview(bannerImageView)
    }
    
    func setFavoriteButton(isFavorite: Bool) {
        favoriteButton.setImage(UIImage(named: isFavorite ? "FavoriteIconFilled" : "FavoriteIconEmpty"), for: .normal)
    }
    
    func updateCartButton() {
        cartButton.setTitle("Added to Cart", for: .normal)
        cartButton.backgroundColor = .systemGreen
    }
}

extension ProductDetailUIElementsProviderImpl: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage:Int = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = currentPage % bannerCount
    }
}
