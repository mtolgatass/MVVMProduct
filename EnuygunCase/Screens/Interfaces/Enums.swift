//
//  Enums.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 23.02.2024.
//

import Foundation

enum ObservationType<T, E> {
    case action(data: T? = nil), error(error: E?)
}
