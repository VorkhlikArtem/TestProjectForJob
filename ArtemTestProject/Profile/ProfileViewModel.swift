//
//  ProfileViewModel.swift
//  ArtemTestProject
//
//  Created by Артём on 18.03.2023.
//

import UIKit

class ProfileViewModel {
    let localDataManager: LocalDataManager
    
    var user: User
    
    init() {
        localDataManager = LocalDataManager.shared
        self.user = localDataManager.currentUser!
    }
    
    var name: String { user.firstName + " " + user.lastName}
    var balance: String {"$ \(user.balance)"}
    var image: UIImage {
        guard let data = user.avatar, let image = UIImage(data: data) else {
            return UIImage(named: "profile")!
        }
        return image
    }
    
    func savePhoto(_ image: UIImage) {
        user.avatar = image.pngData()
        localDataManager.saveCurrentUser(user)
    }
}

extension ProfileViewModel {
    var options: [Option] { [
        Option(image: "wallet", title: "Trade store", hasDisclosure: true, accessoryInfo: nil),
        Option(image: "wallet", title: "Payment method", hasDisclosure: true, accessoryInfo: nil),
        Option(image: "wallet", title: "Balance", hasDisclosure: false, accessoryInfo: balance),
        Option(image: "wallet", title: "Trade history", hasDisclosure: true, accessoryInfo: nil),
        
        Option(image: "restore", title: "Restore Purchase", hasDisclosure: true, accessoryInfo: nil),
        Option(image: "help", title: "Help", hasDisclosure: false, accessoryInfo: nil),
        Option(image: "logout", title: "Log out", hasDisclosure: false, accessoryInfo: nil),
    ]
    }
}
