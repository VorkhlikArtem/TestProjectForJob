//
//  Header.swift
//  ArtemTestProject
//
//  Created by Артём on 15.03.2023.
//

import UIKit

class HeaderWithButton: UICollectionReusableView {
    static let reuseId = "HeaderWithButton"
    
    let title: UILabel = {
        let label = UILabel()
        label.font = .montserratMedium(20)
        label.textColor = #colorLiteral(red: 0.0157645978, green: 0.01523330621, blue: 0.008379653096, alpha: 1)
        return label
    }()
    
    let seeMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(#colorLiteral(red: 0.5019204021, green: 0.5019834638, blue: 0.501899004, alpha: 1), for: .normal)
        button.titleLabel?.font = .montserratRegular(15)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        seeMoreButton.setTitle("View all", for: .normal)
        setupConstraints()
    }
    
    func configure(title: String, buttonText: String) {
        self.title.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(seeMoreButton)
        
        NSLayoutConstraint.activate([
            seeMoreButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            seeMoreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
