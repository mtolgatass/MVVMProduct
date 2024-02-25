//
//  AlertManager.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 23.02.2024.
//

import UIKit

final class AlertManager {
    class func showError(title: String? = nil, message: String? = nil, buttonAction: @escaping() -> Void = {}, controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            buttonAction()
        }
        alertController.addAction(okAction)
        controller.present(alertController, animated: true)
    }
    
    class func showFilterAlert(action: @escaping(ProductListFilterType) -> Void = {_ in },
                               cancelAction: @escaping() -> Void = {},
                               controller: UIViewController) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: "Select Price Range To Filter", preferredStyle: .actionSheet)
        let firstAction: UIAlertAction = UIAlertAction(title: "0 - 500", style: .default) { _ in
            action(.priceRange(min: 0, max: 500))
        }
        let secondAction: UIAlertAction = UIAlertAction(title: "500 - 1000", style: .default) { _ in
            action(.priceRange(min: 500, max: 1000))
        }
        let thirdAction: UIAlertAction = UIAlertAction(title: "1000+", style: .default) { _ in
            action(.priceRange(min: 1000, max: 99999))
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            cancelAction()
        }
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(thirdAction)
        actionSheetController.addAction(cancelAction)
        
        controller.present(actionSheetController, animated: true)
    }
    
    class func showSortAlert(action: @escaping(ProductListSortType) -> Void = {_ in },
                               cancelAction: @escaping() -> Void = {},
                               controller: UIViewController) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: "Select Sort Type", preferredStyle: .actionSheet)
        let firstAction: UIAlertAction = UIAlertAction(title: "Price Ascending", style: .default) { _ in
            action(.priceAsc)
        }
        let secondAction: UIAlertAction = UIAlertAction(title: "Price Descending", style: .default) { _ in
            action(.priceDesc)
        }
        let thirdAction: UIAlertAction = UIAlertAction(title: "A to Z", style: .default) { _ in
            action(.titleAsc)
        }
        let fourthAction: UIAlertAction = UIAlertAction(title: "Z to A", style: .default) { _ in
            action(.titleDesc)
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            cancelAction()
        }
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(thirdAction)
        actionSheetController.addAction(fourthAction)
        actionSheetController.addAction(cancelAction)
        
        controller.present(actionSheetController, animated: true)
    }
}
