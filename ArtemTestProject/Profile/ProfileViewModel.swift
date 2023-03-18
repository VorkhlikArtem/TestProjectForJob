//
//  ProfileViewModel.swift
//  ArtemTestProject
//
//  Created by Артём on 18.03.2023.
//

import UIKit

class ProfileViewModel {
    let user = User(firstName: "Artem", lastName: "Vorkhlik", avatar: UIImage(named: "profile")!, balance: 1500)
    
    var name: String { user.firstName + " " + user.lastName}
    
    var options: [Option] { [
        Option(image: "wallet", title: "Trade store", hasDisclosure: true, accessoryInfo: nil),
        Option(image: "wallet", title: "Payment method", hasDisclosure: true, accessoryInfo: nil),
        Option(image: "wallet", title: "Balance", hasDisclosure: false, accessoryInfo: "$ \(user.balance)"),
        Option(image: "wallet", title: "Trade history", hasDisclosure: true, accessoryInfo: nil),
        
        Option(image: "restore", title: "Restore Purchase", hasDisclosure: true, accessoryInfo: nil),
        Option(image: "help", title: "Help", hasDisclosure: false, accessoryInfo: nil),
        Option(image: "logout", title: "Log out", hasDisclosure: false, accessoryInfo: nil),
    ]
    }
    
}
