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
        let cartNC = generateNavigationController(rootViewController: UIViewController(), image: "cart")
        let messagesNC = generateNavigationController(rootViewController: UIViewController(), image: "messages")
        let profileNC = generateNavigationController(rootViewController: ProfileViewController(), image: "profile")
        
        

        viewControllers = [profileNC, mainNC, favoriteNC, cartNC, messagesNC  ]
    }
    
    
    private func generateNavigationController(rootViewController: UIViewController, image: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = UIImage(named: image)
        return navigationVC
    }
}
