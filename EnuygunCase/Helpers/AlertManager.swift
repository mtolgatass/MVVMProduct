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
}
