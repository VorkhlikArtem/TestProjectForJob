//
//  UILabel +.swift
//  ArtemTestProject
//
//  Created by Артём on 15.03.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String? = nil, font: UIFont?, textColor: UIColor) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
    }
    
    convenience init(text: String? = nil, font: UIFont?, textColor: UIColor, labelColor: UIColor, opacity: Float = 1) {
        self.init(text: text, font: font, textColor: textColor)
        backgroundColor = labelColor
        self.layer.opacity = opacity
    }
}
