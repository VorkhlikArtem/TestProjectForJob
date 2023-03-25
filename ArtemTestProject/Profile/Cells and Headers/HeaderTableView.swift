//
//  HeaderTableView.swift
//  ArtemTestProject
//
//  Created by Артём on 18.03.2023.
//

import UIKit
import Combine

class HeaderTableView: UIView {
    private let changePhotoSubject = PassthroughSubject<Void, Never>()
    var changePhotoPublisher: AnyPublisher<Void, Never> {
        changePhotoSubject.eraseToAnyPublisher()
    }
    
    private let avatarImageView = UIImageView()
    private let changePhotoButton = UIButton(text: "Change photo", font: .montserratMedium(10), textColor: #colorLiteral(red: 0.5019204021, green: 0.5019834638, blue: 0.501899004, alpha: 1))
    private let nameLabel = UILabel(font: .montserratBold(20), textColor: #colorLiteral(red: 0.2470369339, green: 0.2470711172, blue: 0.247025311, alpha: 1))
    private let uploadButton: UIButton = {
        let button = UIButton.init(type: .system)
        var config = UIButton.Configuration.filled()
        
        var container = AttributeContainer()
        container.font = .montserratBold(10)
        container.foregroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        config.attributedTitle = AttributedString("Upload item", attributes: container)
        
        config.baseForegroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        config.baseBackgroundColor = #colorLiteral(red: 0.306866169, green: 0.3334070146, blue: 0.8420930505, alpha: 1)
        config.cornerStyle = .large
        config.imagePadding = 30
        config.contentInsets = .init(top: 10, leading: 30, bottom: 10, trailing: 60)
        config.image = UIImage(named: "upload")
        button.configuration = config
        return button
    }()
    
    init(image: UIImage, name: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 300, height: 180))
        setupConstaints()
        avatarImageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.image = image
        nameLabel.text = name
        changePhotoButton.addTarget(self, action: #selector(changePhotoTapped), for: .touchUpInside)
        uploadButton.addTarget(self, action: #selector(changePhotoTapped), for: .touchUpInside)
    }
    
    func setImage(image: UIImage) {
        avatarImageView.image = image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
    }
    
    @objc private func changePhotoTapped() {
        changePhotoSubject.send()
    }
    
    // MARK: - Setup Constaints
    func setupConstaints() {
        changePhotoButton.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        let vStack = UIStackView(arrangedSubviews: [avatarImageView, changePhotoButton, nameLabel, uploadButton])
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.setCustomSpacing(20, after: nameLabel)
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
        
        ])
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
