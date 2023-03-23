//
//  AppCoordinator.swift
//  ArtemTestProject
//
//  Created by Артём on 22.03.2023.
//

import UIKit
import Combine

class AppCoordinator: Coordinator {
    
//    var currentUserSubject = CurrentValueSubject<User?, Never>(nil)
    
    var rootVC: UIViewController = UIViewController()
    let window: UIWindow?
    var childCoordinators = [Coordinator]()
    let localDataManager = LocalDataManager.shared
    var subscriptions = Set<AnyCancellable>()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let currentUserId = localDataManager.currentUserIdPublisher
//        currentUserSubject.send(currentUser)
        
        currentUserId.sink { [weak self] currentUserId in
            if currentUserId != nil {
                print(currentUserId!)
                self?.createMainFlow()
            } else {
                self?.createAuthFlow()
            }
        }.store(in: &subscriptions)
        
    }
    
    private func createAuthFlow() {
        let authCoordinator = AuthCoordinator()
        authCoordinator.start()
        childCoordinators = [authCoordinator]
        window?.rootViewController = authCoordinator.rootVC
    }
    
    private func createMainFlow() {
        let mainCoordinator = MainCoordinator()
        mainCoordinator.start()
        childCoordinators = [mainCoordinator]
        window?.rootViewController = mainCoordinator.rootVC
    }
     
}
