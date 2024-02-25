//
//  Enums.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 23.02.2024.
//

import Foundation

enum ObservationType<E> {
    case error(error: E?)
}

enum ProductListFilterType {
    case priceRange(min: Int, max: Int)
}

enum ProductListSortType {
    case priceAsc
    case priceDesc
    case titleAsc
    case titleDesc
}
