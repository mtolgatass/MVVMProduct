//
//  CheckoutUIElementsProvider.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation
import UIKit
import SnapKit

protocol CheckoutUIElementsProvider {
    func addSubviews(targetView: UIView)
    func addConstraints(targetView: UIView)
    var payButton: UIButton { get }
    var nameTextField: UITextField { get }
    var emailTextField: UITextField { get }
    var phoneTextField: UITextField { get }
}

final class CheckoutUIElementsProviderImpl: CheckoutUIElementsProvider {
    private var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(4)
        textField.layer.borderColor = UIColor.systemGray.cgColor
        return textField
    }()
    
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(4)
        textField.layer.borderColor = UIColor.systemGray.cgColor
        return textField
    }()
    
    var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone"
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(4)
        textField.layer.borderColor = UIColor.systemGray.cgColor
        return textField
    }()
    
    private var emptyView: UIView = {
        let view = UIView()
        return view
    }()
    
    var payButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pay", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    
    func addSubviews(targetView: UIView) {
        targetView.addSubview(containerStack)
        containerStack.addArrangedSubview(nameTextField)
        containerStack.addArrangedSubview(emailTextField)
        containerStack.addArrangedSubview(phoneTextField)
        containerStack.addArrangedSubview(emptyView)
        containerStack.addArrangedSubview(payButton)
    }
    
    func addConstraints(targetView: UIView) {
        containerStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalTo(targetView.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(targetView.safeAreaLayoutGuide.snp.bottom)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        payButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
