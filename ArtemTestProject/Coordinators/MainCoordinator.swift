//
//  MainCoordinator.swift
//  ArtemTestProject
//
//  Created by Артём on 22.03.2023.
//

import UIKit

class MainCoordinator: Coordinator {
    var rootVC: UIViewController = UITabBarController()

    
    func start() {
        let mainTabBarController = MainTabBarController()
        rootVC = mainTabBarController
    }
    
}
