//
//  CheckoutUIElementsProvider.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import Foundation
import UIKit
import SnapKit
import Lottie

protocol CheckoutUIElementsProvider {
    func addSubviews(targetView: UIView)
    func addConstraints(targetView: UIView)
    func showSuccessView()
    var payButton: UIButton { get }
    var goBackButton: UIButton { get }
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
    
    // Success View
    private var successStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = .black
        stack.spacing = 8
        stack.isHidden = true
        return stack
    }()
    
    private var emptyViewTwo: UIView = {
        let view = UIView()
        return view
    }()
    
    private var paymentSuccessLabel: UILabel = {
        let label = UILabel()
        label.text = "Payment is successful!"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private var lottieContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private var lottieView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.animation = LottieAnimation.named("mobile-payment")
        view.loopMode = .loop
        view.animationSpeed = 0.75
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var goBackButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go Back", for: .normal)
        button.backgroundColor = .systemGreen
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
        
        // Success View
        targetView.addSubview(successStack)
        successStack.addArrangedSubview(emptyViewTwo)
        successStack.addArrangedSubview(paymentSuccessLabel)
        successStack.addArrangedSubview(lottieContainer)
        lottieContainer.addSubview(lottieView)
        successStack.addArrangedSubview(goBackButton)
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
        
        // Success View
        successStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(targetView.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(targetView.safeAreaLayoutGuide.snp.bottom)
        }
        
        emptyViewTwo.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        paymentSuccessLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        lottieView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        goBackButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
    func showSuccessView() {
        containerStack.isHidden = true
        successStack.isHidden = false
        lottieView.play()
    }
}
