//
//  ColorSegmentedControl.swift
//  ArtemTestProject
//
//  Created by Артём on 16.03.2023.
//

import UIKit

class ColorSegmentedControl: UIStackView {
    
    var selectedButtonIndex: Int? = 0
    
    private var buttons: [UIButton] {
        return self.arrangedSubviews as! [UIButton]
    }


    init(productColors: [String]) {
        super.init(frame: .zero)
        
        self.axis = .horizontal
        distribution = .fillEqually
        spacing = 18
        setupStackView(with: productColors)
        setupConstraints()
    }
    
    private func setupStackView(with hexColors: [String]) {
        let uiColors = hexColors.map { UIColor(hex: $0)}
        
        uiColors.forEach { color in
            let colorButton: UIButton = {
                let button = UIButton(type: .system)
                button.backgroundColor = color
                button.layer.cornerRadius = 10
                button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
                button.layer.borderWidth = 3
                
                button.addTarget(self, action: #selector(selectButton), for: .touchUpInside)
                return button
            }()
            self.addArrangedSubview(colorButton)
        }
    }
    
    
    @objc private func selectButton(selectedButton: UIButton) {
        for button in buttons {
            button.layer.borderColor =  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        }
        selectedButton.layer.borderColor = UIColor.orange.cgColor
    }
    
    private func  setupConstraints() {
        buttons.forEach { button in
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 30).isActive = true
            button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
