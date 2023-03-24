//
//  CustomTextField.swift
//  ArtemTestProject
//
//  Created by Артём on 18.03.2023.
//

import UIKit

class CustomTextField: UITextField {
    init(placeholder: String, isPassword: Bool = false) {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.9097340107, green: 0.909843266, blue: 0.909696877, alpha: 1)
        font = .montserratRegular(10)
        textColor = .black
        clearButtonMode = .whileEditing
        borderStyle = .none
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 30).isActive = true

        let fontAttribute = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4823140502, green: 0.4823748469, blue: 0.4822933078, alpha: 1) as Any]
        let nsString = NSAttributedString(string: placeholder, attributes: fontAttribute)
        attributedPlaceholder = nsString
        
        if isPassword {
            self.isSecureTextEntry = true
            setupSecureEye()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = frame.height/2
    }
    
    private func setupSecureEye() {
        let eyeButton = UIButton(type: .system)
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        eyeButton.tintColor = #colorLiteral(red: 0.4823140502, green: 0.4823748469, blue: 0.4822933078, alpha: 1)
        eyeButton.addTarget(self, action: #selector(eyeTapped), for: .touchUpInside)
        rightView = eyeButton
        rightViewMode = .always
        
        eyeButton.configuration = UIButton.Configuration.plain()
        eyeButton.configuration?.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 10)
        
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 0))
    }
    
    @objc func eyeTapped(eyeButton: UIButton) {
        self.isSecureTextEntry.toggle()
        if isSecureTextEntry {
            eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
