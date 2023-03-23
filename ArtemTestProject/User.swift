//
//  User.swift
//  ArtemTestProject
//
//  Created by Артём on 18.03.2023.
//

import Foundation
import UIKit

struct User: Codable {
    var firstName: String
    var lastName: String
    let email: String
    var avatar: Data?
    var balance: Int
}

