//
//  UIFont +.swift
//  ArtemTestProject
//
//  Created by Артём on 16.03.2023.
//

import UIKit

extension UIFont {
    
    static func montserratRegular(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "Montserrat-Regular", size: size)
    }
    
    static func montserratBold(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "Montserrat-Bold", size: size)
    }
    
    static func montserratMedium(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "Montserrat-Medium", size: size)
    }
}
