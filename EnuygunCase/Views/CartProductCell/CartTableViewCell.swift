//
//  CartTableViewCell.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import UIKit
import RxSwift

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productTitle: UILabel!
    @IBOutlet private weak var productPrice: UILabel!
    @IBOutlet private weak var quantityLabel: UILabel!
    
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    var bag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func configureCell(_ model: Product, _ count: Int) {
        productTitle.text = model.title
        productImage.loadImage(from: model.thumbnail)
        
        if model.discountPercentage > 0 {
            let discountedPrice = Double(model.price) - (Double(model.price) * model.discountPercentage / 100)
            let priceText = "\(Int(discountedPrice)) TL "
            let attributePriceString: NSMutableAttributedString =  NSMutableAttributedString(string: priceText)
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: " \(model.price) TL")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            attributeString.append(attributePriceString)
            productPrice.attributedText = attributeString
        } else {
            productPrice.text = "\(model.price) TL"
        }
        
        quantityLabel.text = "\(count)"
    }
}
