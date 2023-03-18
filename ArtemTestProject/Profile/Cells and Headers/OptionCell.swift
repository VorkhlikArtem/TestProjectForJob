//
//  OptionCell.swift
//  ArtemTestProject
//
//  Created by Артём on 18.03.2023.
//

import UIKit

class OptionCell: UITableViewCell {
    static var reuseId: String = "OptionCell"
    
    let leftImageView = UIButton(imageColor: #colorLiteral(red: 0.0157645978, green: 0.01523330621, blue: 0.008379653096, alpha: 1), buttonColor: #colorLiteral(red: 0.9337416887, green: 0.9382420778, blue: 0.9553256631, alpha: 1))
    let title = UILabel(font: .montserratMedium(15), textColor: #colorLiteral(red: 0.0157645978, green: 0.01523330621, blue: 0.008379653096, alpha: 1))
    let secondaryText = UILabel(font: .montserratMedium(15), textColor: #colorLiteral(red: 0.0157645978, green: 0.01523330621, blue: 0.008379653096, alpha: 1))
    let accessoryImageView = UIButton(image: "right", imageColor: #colorLiteral(red: 0.0157645978, green: 0.01523330621, blue: 0.008379653096, alpha: 1))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        leftImageView.backgroundColor = #colorLiteral(red: 0.9337416887, green: 0.9382420778, blue: 0.9553256631, alpha: 1)
        backgroundColor = .clear
        setupConstraints()
        
    }
    
    func configure(option: Option) {
        leftImageView.setImage(UIImage(named: option.image), for: .normal)
        title.text = option.title
        secondaryText.text = option.accessoryInfo
        accessoryImageView.isHidden = !option.hasDisclosure
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leftImageView.clipsToBounds = true
        leftImageView.layer.cornerRadius = leftImageView.frame.height/2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        let hStack = UIStackView(arrangedSubviews: [leftImageView, title, secondaryText, accessoryImageView])
        hStack.axis = .horizontal
        hStack.spacing = 5
        hStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hStack)
        NSLayoutConstraint.activate([
            hStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        
            leftImageView.heightAnchor.constraint(equalToConstant: 40),
            leftImageView.widthAnchor.constraint(equalToConstant: 40),
        ])
        leftImageView.isUserInteractionEnabled = false
        accessoryImageView.isUserInteractionEnabled = false
    }
}
