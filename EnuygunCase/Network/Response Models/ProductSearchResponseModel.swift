//
//  ProductSearchResponseModel.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 23.02.2024.
//

import Foundation

struct ProductSearchResponseModel: Codable {
    let products: [Product]
    let total: Int
}
