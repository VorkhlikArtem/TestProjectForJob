//
//  MainTabController.swift
//  ArtemTestProject
//
//  Created by Артём on 17.03.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        setupTabBar()
    }
    
    private func setupTabBar() {
        let mainNC = generateNavigationController(rootViewController: MainViewController(), image: "house")
        let favoriteNC = generateNavigationController(rootViewController: DetailViewController(), image: "heart")
        let cartNC = generateNavigationController(rootViewController: SignInViewController(), image: "cart")
        let messagesNC = generateNavigationController(rootViewController: LoginViewController(), image: "messages")
        let profileNC = generateNavigationController(rootViewController: ProfileViewController(), image: "profile")
        
        

        viewControllers = [messagesNC, cartNC,   profileNC, mainNC, favoriteNC  ]
    }
    
    
    private func generateNavigationController(rootViewController: UIViewController, image: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = UIImage(named: image)
        return navigationVC
    }
}
