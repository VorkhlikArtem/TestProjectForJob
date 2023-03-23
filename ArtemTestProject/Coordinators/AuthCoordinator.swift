//
//  AuthCoordinator.swift
//  ArtemTestProject
//
//  Created by Артём on 22.03.2023.
//

import UIKit
import Combine

class AuthCoordinator: Coordinator {
    var rootVC: UIViewController = UINavigationController()
    
    var subscriptions = Set<AnyCancellable>()
    let localDataManager = LocalDataManager.shared
    
    
    func start() {
        let signInVC = SignInViewController()
        signInVC.alreadyHaveButtonTapped.sink { [weak self] in
            self?.createLogin()
        }.store(in: &signInVC.subscriptions)
        
        (rootVC as? UINavigationController)?.setViewControllers([signInVC], animated: false)
    
    }
    
    private func createLogin() {
        let loginVC = LoginViewController()
        (rootVC as? UINavigationController)?.pushViewController(loginVC, animated: true)
    }
    
}
