//
//  LoginViewController.swift
//  ArtemTestProject
//
//  Created by Артём on 19.03.2023.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    var loginButtonTapped = PassthroughSubject<Void, Never>()
    let authService = AuthService()
    var subscriptions = Set<AnyCancellable>()
    
    let titleLabel = UILabel(text: "Welcome back", font: .montserratMedium(30), textColor: #colorLiteral(red: 0.08607355505, green: 0.09469824284, blue: 0.1493803263, alpha: 1))
    let emailTextField = CustomTextField(placeholder: "Email")
    let passwordTextField = CustomTextField(placeholder: "Password", isPassword: true)
    let loginButton = UIButton(text: "Login", font: .montserratBold(15), textColor: .white, buttonColor: #colorLiteral(red: 0.306866169, green: 0.3334070146, blue: 0.8420930505, alpha: 1))
    let errorLabel = UILabel(font: .montserratBold(20), textColor: .red)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        loginButton.layer.cornerRadius = 10
        setupConstraints()
        hideKeyboardAfterTapping()
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    @objc private func loginTapped() {
        authService.login(email: emailTextField.text, password: passwordTextField.text).sink { completion in
            switch completion {
            case .finished: break
            case .failure(let error) :
                guard let error = error as? AuthError else {return}
                self.errorLabel.text = error.errorDescription

            }
        } receiveValue: { user in
            print(user)
            self.loginButtonTapped.send()
        }.store(in: &subscriptions)


    }
    
}

// MARK: - Setup Constraints
extension LoginViewController {
    private func setupConstraints() {
        titleLabel.textAlignment = .center
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.heightAnchor.constraint(equalToConstant: 47).isActive = true
        
        let vStack = UIStackView(arrangedSubviews: [titleLabel, emailTextField, passwordTextField, errorLabel, loginButton])
        vStack.axis = .vertical
        vStack.spacing = 25
        vStack.setCustomSpacing(50, after: titleLabel)
        vStack.setCustomSpacing(10, after: passwordTextField)
        vStack.setCustomSpacing(40, after: errorLabel)
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
        
    }
}
