//
//  CustomNavigationBar.swift
//  ArtemTestProject
//
//  Created by Артём on 15.03.2023.
//

import UIKit

class CustomNavigationBar: UINavigationBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: frame.size.width, height: 200)
    }
}
