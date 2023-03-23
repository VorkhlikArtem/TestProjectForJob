//
//  Coordinator .swift
//  ArtemTestProject
//
//  Created by Артём on 22.03.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var rootVC: UIViewController {get set}
    func start()
}
