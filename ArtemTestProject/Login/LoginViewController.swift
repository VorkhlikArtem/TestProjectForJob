//
//  LoginViewController.swift
//  ArtemTestProject
//
//  Created by Артём on 19.03.2023.
//

import UIKit

class LoginViewController: UIViewController {
    let titleLabel = UILabel(text: "Welcome back", font: .montserratMedium(30), textColor: #colorLiteral(red: 0.08607355505, green: 0.09469824284, blue: 0.1493803263, alpha: 1))
    let emailTextField = CustomTextField(placeholder: "Email")
    let passwordTextField = CustomTextField(placeholder: "Password", isPassword: true)
    let loginButton = UIButton(text: "Login", font: .montserratBold(15), textColor: .white, buttonColor: #colorLiteral(red: 0.306866169, green: 0.3334070146, blue: 0.8420930505, alpha: 1))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        loginButton.layer.cornerRadius = 10
        setupConstraints()
        hideKeyboardAfterTapping()
    }
    
}

// MARK: - Setup Constraints
extension LoginViewController {
    private func setupConstraints() {
        titleLabel.textAlignment = .center
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.heightAnchor.constraint(equalToConstant: 47).isActive = true
        
        let vStack = UIStackView(arrangedSubviews: [titleLabel, emailTextField, passwordTextField, loginButton])
        vStack.axis = .vertical
        vStack.spacing = 25
        vStack.setCustomSpacing(50, after: titleLabel)
        vStack.setCustomSpacing(60, after: passwordTextField)
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
        
    }
}
