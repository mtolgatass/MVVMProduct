//
//  CommonModels.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 23.02.2024.
//

import Foundation

// MARK: - Product
struct Product: Codable, Equatable, Hashable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: URL
    let images: [URL]

    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.description == rhs.description &&
            lhs.price == rhs.price &&
            lhs.discountPercentage == rhs.discountPercentage &&
            lhs.rating == rhs.rating &&
            lhs.stock == rhs.stock &&
            lhs.brand == rhs.brand &&
            lhs.category == rhs.category &&
            lhs.thumbnail == rhs.thumbnail &&
            lhs.images == rhs.images
    }
}
