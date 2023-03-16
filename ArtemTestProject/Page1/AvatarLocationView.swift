//
//  AvatarLocationView.swift
//  ArtemTestProject
//
//  Created by Артём on 15.03.2023.
//

import UIKit

class AvatarLocationView: UIStackView {
    let avatarImageView = UIImageView()
    
    let locationButton: UIButton = {
        var config = UIButton.Configuration.plain()
        
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 14)
        container.foregroundColor = #colorLiteral(red: 0.3568329215, green: 0.3568795323, blue: 0.3568170071, alpha: 1)
        
        config.attributedTitle = AttributedString("Location", attributes: container)
        config.image = UIImage(named: "down")
        config.imagePadding = 5
        config.imagePlacement = .trailing
        return UIButton(configuration: config, primaryAction: nil)
    }()
        
    
    init(_ image: UIImage?) {
        super.init(frame: .zero)
        avatarImageView.image = image ?? UIImage(named: "person.crop.circle.fill")
        axis = .vertical
        alignment = .center
        
        addArrangedSubview(avatarImageView)
        addArrangedSubview(locationButton)
        
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 30),
            avatarImageView.widthAnchor.constraint(equalToConstant: 30),

        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
