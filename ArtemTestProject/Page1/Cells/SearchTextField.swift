//
//  SearchTextField.swift
//  ArtemTestProject
//
//  Created by Артём on 15.03.2023.
//

import UIKit

class SearchTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.9613562226, green: 0.9647707343, blue: 0.9681481719, alpha: 1)
        textColor = #colorLiteral(red: 0.3568329215, green: 0.3568795323, blue: 0.3568170071, alpha: 1)
        tintColor = #colorLiteral(red: 0.3568329215, green: 0.3568795323, blue: 0.3568170071, alpha: 1)
        textAlignment = .center
        placeholder = "What are you looking for?"
   
        font = .systemFont(ofSize: 14, weight: .regular)
        clearButtonMode = .whileEditing
        borderStyle = .none
        layer.masksToBounds = true
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        rightView = button
        rightViewMode = .always
        rightView?.frame = .init(x: 0, y: 0, width: 19, height: 19)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 10)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 10)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 10)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= 20
        return rect
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
