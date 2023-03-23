//
//  SignInViewController.swift
//  ArtemTestProject
//
//  Created by Артём on 18.03.2023.
//

import UIKit
import Combine

class SignInViewController: UIViewController {
    let authService = AuthService()
    var alreadyHaveButtonTapped = PassthroughSubject<Void, Never>()
    var signinButtonTapped = PassthroughSubject<Void, Never>()
    var subscriptions = Set<AnyCancellable>()
    
    let titleLabel = UILabel(text: "Sign In", font: .montserratMedium(30), textColor: #colorLiteral(red: 0.08607355505, green: 0.09469824284, blue: 0.1493803263, alpha: 1))
    let errorLabel = UILabel(font: .montserratBold(15), textColor: .red)
    let firstNameTextField = CustomTextField(placeholder: "First name")
    let lastNameTextField = CustomTextField(placeholder: "Last name")
    let emailTextField = CustomTextField(placeholder: "Email")
    let signInButton = UIButton(text: "Sign In", font: .montserratBold(15), textColor: .white, buttonColor: #colorLiteral(red: 0.306866169, green: 0.3334070146, blue: 0.8420930505, alpha: 1))
    
    let haveAccountLabel = UILabel(text: "Already have an account?", font: .montserratRegular(10), textColor: #colorLiteral(red: 0.5019204021, green: 0.5019834638, blue: 0.501899004, alpha: 1))
    let loginButton = UIButton(text: "Log in", font: .montserratRegular(10), textColor: #colorLiteral(red: 0.306866169, green: 0.3334070146, blue: 0.8420930505, alpha: 1))
    
    let googleButton: UIButton = {
        let button = UIButton.init(type: .system)
        var config = UIButton.Configuration.plain()
        
        var container = AttributeContainer()
        container.font = .montserratRegular(15)
        config.attributedTitle = AttributedString("Sign in with Google", attributes: container)
        
        config.baseForegroundColor = .black
        config.imagePadding = 10
        config.image = UIImage(named: "google")
        button.configuration = config
        return button
    }()
    
    let appleButton: UIButton = {
        let button = UIButton.init(type: .system)
        var config = UIButton.Configuration.plain()
        
        var container = AttributeContainer()
        container.font = .montserratRegular(15)
        config.attributedTitle = AttributedString("Sign in with Apple", attributes: container)
        
        config.baseForegroundColor = .black
        config.imagePadding = 10
        config.image = UIImage(named: "apple")
        button.configuration = config
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        signInButton.layer.cornerRadius = 10
        setupConstraints()
        hideKeyboardAfterTapping()
        loginButton.addTarget(self, action: #selector(alreadyHaveTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signinTapped), for: .touchUpInside)
    }
    
    @objc private func alreadyHaveTapped() {
        alreadyHaveButtonTapped.send()
    }
    
    @objc private func signinTapped() {
        authService.signin(firstName: firstNameTextField.text, lastName: lastNameTextField.text, email: emailTextField.text) .sink { completion in
            switch completion {
            case .finished: break
            case .failure(let error) :
                guard let error = error as? AuthError else {return}
                self.errorLabel.text = error.errorDescription

            }
        } receiveValue: { user in
            print(user)
           // self.signinButtonTapped.send()
        }.store(in: &subscriptions)
    }
    
}

// MARK: - Setup Constraints
extension SignInViewController {
    private func setupConstraints() {
        let separator = UIView()
        separator.setContentHuggingPriority(.defaultLow, for: .horizontal)
        let hStack = UIStackView(arrangedSubviews: [haveAccountLabel, loginButton, separator])
        hStack.spacing = 5
        hStack.axis = .horizontal
        
        titleLabel.textAlignment = .center
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.heightAnchor.constraint(equalToConstant: 47).isActive = true
        
        let vStack = UIStackView(arrangedSubviews: [titleLabel, firstNameTextField, lastNameTextField, emailTextField, signInButton,  hStack, googleButton, appleButton])
        vStack.axis = .vertical
        vStack.spacing = 20
        vStack.setCustomSpacing(50, after: titleLabel)
        vStack.setCustomSpacing(5, after: signInButton)
        vStack.setCustomSpacing(50, after: hStack)
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        vStack.addSubview(errorLabel)
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            errorLabel.leadingAnchor.constraint(equalTo: firstNameTextField.leadingAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: firstNameTextField.topAnchor, constant: -10)
        ])
        
    }
}
