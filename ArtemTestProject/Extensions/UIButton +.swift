//
//  UIButton +.swift
//  ArtemTestProject
//
//  Created by Артём on 15.03.2023.
//
import UIKit

extension UIButton {
    convenience init(text: String, font: UIFont?, textColor: UIColor, buttonColor: UIColor? = nil) {
        self.init(type: .system)
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = buttonColor
    }
    
    convenience init(image: String, imageColor: UIColor, buttonColor: UIColor? = nil) {
        self.init(type: .system)
        self.setImage(UIImage(named: image), for: .normal)
        self.tintColor = imageColor
        self.backgroundColor = buttonColor
    }
    
    convenience init(text: String? = nil, font: UIFont?, textColor: UIColor, buttonColor: UIColor? = nil, image: String, imageColor: UIColor) {
        self.init(type: .system)
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = buttonColor
        
        self.setImage(UIImage(named: image), for: .normal)
        self.tintColor = imageColor
    }
    
    convenience init(imageColor: UIColor, buttonColor: UIColor? = nil) {
        self.init(type: .system)
        self.tintColor = imageColor
        self.backgroundColor = buttonColor
    }
}
