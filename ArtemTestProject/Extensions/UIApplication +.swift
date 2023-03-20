//
//  UIApplication +.swift
//  ArtemTestProject
//
//  Created by Артём on 19.03.2023.
//

import UIKit

extension UIApplication {
    static var currentKeyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .filter{$0.activationState == .foregroundActive}
            .map{$0 as? UIWindowScene}
            .compactMap{$0}
            .first?.windows
            .filter{$0.isKeyWindow}.first
    }
    
}
