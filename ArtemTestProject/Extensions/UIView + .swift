//
//  UIView + .swift
//  ArtemTestProject
//
//  Created by Артём on 17.03.2023.
//

import UIKit

extension UIView {
    func addSubviewWithWholeFilling(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor),
            subview.leadingAnchor.constraint(equalTo: leadingAnchor),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor)

        ])
    }
    
    func addSubviewAtTheBottom(subview: UIView, height: CGFloat) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor),
            subview.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
