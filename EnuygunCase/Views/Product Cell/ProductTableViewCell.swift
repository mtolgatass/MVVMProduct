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
    
//    override class func awakeFromNib() {
//        super.awakeFromNib()
//    }
    
    func configureCell(_ model: Product) {
        productNameLabel.text = model.title
        productInfoLabel.text = model.description
        productPriceLabel.text = "\(model.price) TL"
    }
}
