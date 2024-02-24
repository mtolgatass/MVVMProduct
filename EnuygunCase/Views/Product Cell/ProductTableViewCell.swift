//
//  ProductTableViewCell.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productInfoLabel: UILabel!
    @IBOutlet private weak var productDiscountedPriceLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        productImage.image = nil
        productNameLabel.text = ""
        productInfoLabel.text = ""
        productDiscountedPriceLabel.text = ""
        productPriceLabel.attributedText = nil
    }
    
    func configureCell(_ model: Product) {
        productNameLabel.text = model.title
        productInfoLabel.text = model.description
        productImage.loadImage(from: model.thumbnail)
        
        if model.discountPercentage > 0 {
            let discountedPrice = Double(model.price) - (Double(model.price) * model.discountPercentage / 100)
            productDiscountedPriceLabel.text = "\(Int(discountedPrice)) TL"
            
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(model.price) TL")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            productPriceLabel.attributedText = attributeString
        } else {
            productPriceLabel.attributedText = nil
            productDiscountedPriceLabel.text = "\(model.price) TL"
        }
    }
}
