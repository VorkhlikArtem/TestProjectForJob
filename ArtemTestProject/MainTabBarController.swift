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
        setTabBarAppearance()
    }
    
    private func setupTabBar() {
        let mainNC = generateNavigationController(rootViewController: MainViewController(), image: "house")
        let favoriteNC = generateNavigationController(rootViewController: DetailViewController(), image: "heart")
        let cartNC = generateNavigationController(rootViewController: SignInViewController(), image: "cart")
        let messagesNC = generateNavigationController(rootViewController: LoginViewController(), image: "messages")
        let profileNC = generateNavigationController(rootViewController: ProfileViewController(), image: "profile")
        
        viewControllers = [mainNC,  messagesNC, cartNC,   profileNC,  favoriteNC  ]
    }
    
    
    private func generateNavigationController(rootViewController: UIViewController, image: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = UIImage(named: image)
        return navigationVC
    }
    
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = -1
        let positionOnY: CGFloat = 10
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY + 5 ,
                width: width,
                height: height
            ),
            cornerRadius: height / 2
        )
       
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.white.cgColor
        
        tabBar.tintColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.5646609664, green: 0.5647310615, blue: 0.5646371245, alpha: 1)
    }
}
