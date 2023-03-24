//
//  LatestCell.swift
//  ArtemTestProject
//
//  Created by Артём on 15.03.2023.
//

import UIKit

class LatestCell: UICollectionViewCell {
    
    static var reuseId: String = "HotSalesCell"
    
    let productImageView = WebImageView()
    let categoryLabel = CustomLabel(font: .montserratMedium(10), textColor: #colorLiteral(red: 0.02684249915, green: 0.02328234538, blue: 0.01631845906, alpha: 1), labelColor: #colorLiteral(red: 0.7685678005, green: 0.7686610222, blue: 0.7685361505, alpha: 1), opacity: 0.85)

    let titleLabel = UILabel(font: .montserratBold(10), textColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    let priceLabel = UILabel(font: .montserratRegular(10) , textColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    let addButton = UIButton(image: "plus", imageColor: #colorLiteral(red: 0.3298887014, green: 0.3344107866, blue: 0.5370991826, alpha: 1), buttonColor: #colorLiteral(red: 0.8972175121, green: 0.9143759608, blue: 0.9387496114, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
        productImageView.contentMode = .scaleAspectFill
        categoryLabel.textAlignment = .center
        categoryLabel.textInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
        setupConstraints()
    }
    
    override func prepareForReuse() {
        productImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addButton.clipsToBounds = true
        addButton.layer.cornerRadius = addButton.frame.height/2
        categoryLabel.clipsToBounds = true
        categoryLabel.layer.cornerRadius = categoryLabel.frame.height / 2
    }
    
    
    func configure(with latestViewModel: LatestItem) {
        productImageView.set(imageURL: latestViewModel.imageUrl)
        categoryLabel.text = latestViewModel.category
        titleLabel.text = latestViewModel.name
        priceLabel.text = latestViewModel.formattedPrice
    }
    
    func setupConstraints() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(productImageView)
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor)

        ])
        
        let vStack = UIStackView(arrangedSubviews: [categoryLabel, titleLabel, priceLabel])
        vStack.axis = .vertical
        vStack.distribution = .equalSpacing
        vStack.spacing = 6
        vStack.alignment = .leading
        vStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        ])
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


