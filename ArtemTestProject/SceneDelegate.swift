//
//  SceneDelegate.swift
//  ArtemTestProject
//
//  Created by Артём on 14.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var applicationCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
        applicationCoordinator = appCoordinator
        
        window.makeKeyAndVisible()
    }

  


}

