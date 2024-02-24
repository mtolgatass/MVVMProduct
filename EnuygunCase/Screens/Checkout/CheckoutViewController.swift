//
//  CheckoutViewController.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import UIKit
import RxSwift
import RxCocoa

class CheckoutViewController: UIViewController {
    
    private var pr: CheckoutUIElementsProvider?
    private var vm: CheckoutViewModel?
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Checkout"
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = true
        
        pr?.addSubviews(targetView: self.view)
        pr?.addConstraints(targetView: self.view)
        bindUIProvider()
    }
    
    private func bindUIProvider() {
        guard let pr = pr else { return }
        
        pr.payButton.rx
            .tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if self.checkInputFields() {
                    pr.showSuccessView()
                    vm?.emptyCart()
                    print("Payment successful")
                } else {
                    AlertManager.showError(title: "Error", message: "Please check input fields", controller: self)
                }
            }).disposed(by: bag)
        
        pr.goBackButton.rx
            .tap
            .subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: bag)
    }
    
    private func checkInputFields() -> Bool {
        var result = true
        if pr?.nameTextField.text?.count ?? 0 < 3 {
            pr?.nameTextField.layer.borderColor = UIColor.red.cgColor
            result = false
        } else {
            pr?.nameTextField.layer.borderColor = UIColor.systemGray.cgColor
        }
        
        if pr?.emailTextField.text?.count ?? 0 < 3 {
            pr?.emailTextField.layer.borderColor = UIColor.red.cgColor
            result = false
        } else {
            pr?.nameTextField.layer.borderColor = UIColor.systemGray.cgColor
        }
        
        if pr?.phoneTextField.text?.count ?? 0 < 3 {
            pr?.phoneTextField.layer.borderColor = UIColor.red.cgColor
            result = false
        } else {
            pr?.phoneTextField.layer.borderColor = UIColor.systemGray.cgColor
        }
        return result
    }
}

extension CheckoutViewController {
    func inject(pr: CheckoutUIElementsProvider, vm: CheckoutViewModel) {
        self.pr = pr
        self.vm = vm
    }
}
