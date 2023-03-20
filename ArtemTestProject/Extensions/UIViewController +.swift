//
//  UIViewController +.swift
//  ArtemTestProject
//
//  Created by Артём on 20.03.2023.
//

import UIKit

extension UIViewController {
    func hideKeyboardAfterTapping() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismisskeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismisskeyboard() {
        view.endEditing(true)
    }
}
