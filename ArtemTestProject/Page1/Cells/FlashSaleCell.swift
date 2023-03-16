//
//  FlashSaleCell.swift
//  ArtemTestProject
//
//  Created by Артём on 15.03.2023.
//

import UIKit

class FlashSaleCell: UICollectionViewCell {
    static var reuseId: String = "FlashSaleCell"
    
    let productImageView = WebImageView()
    
    let categoryLabel = CustomLabel(font: .montserratRegular(15), textColor: #colorLiteral(red: 0.02684249915, green: 0.02328234538, blue: 0.01631845906, alpha: 1), labelColor: #colorLiteral(red: 0.7685678005, green: 0.7686610222, blue: 0.7685361505, alpha: 1), opacity: 0.85)
    let titleLabel = UILabel(font: .montserratBold(15), textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
    let priceLabel = UILabel(font: .montserratRegular(15) , textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
    let addButton = UIButton(image: "plus", imageColor: #colorLiteral(red: 0.3298887014, green: 0.3344107866, blue: 0.5370991826, alpha: 1), buttonColor: #colorLiteral(red: 0.8972175121, green: 0.9143759608, blue: 0.9387496114, alpha: 1))
    let discountLabel = CustomLabel(font: .montserratRegular(15), textColor: .white, labelColor: #colorLiteral(red: 0.9187640548, green: 0.2557073832, blue: 0.21827811, alpha: 1))
    let likeButton = UIButton(image: "heart", imageColor: #colorLiteral(red: 0.3298887014, green: 0.3344107866, blue: 0.5370991826, alpha: 1), buttonColor: #colorLiteral(red: 0.8972175121, green: 0.9143759608, blue: 0.9387496114, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
        productImageView.contentMode = .scaleAspectFill
        categoryLabel.textAlignment = .center
        categoryLabel.textInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
        discountLabel.textInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
        setupConstraints()
    }
    
   
    func configure(with flashSaleViewModel: FlashSaleItem) {
        productImageView.set(imageURL: flashSaleViewModel.imageUrl)
        categoryLabel.text = flashSaleViewModel.category
        titleLabel.text = flashSaleViewModel.name
        priceLabel.text = flashSaleViewModel.formattedPrice
        discountLabel.text = "\(flashSaleViewModel.discount)% off"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addButton.clipsToBounds = true
        addButton.layer.cornerRadius = addButton.frame.height/2
        categoryLabel.clipsToBounds = true
        categoryLabel.layer.cornerRadius = categoryLabel.frame.height / 2
        
        likeButton.clipsToBounds = true
        likeButton.layer.cornerRadius = likeButton.frame.height/2
        discountLabel.clipsToBounds = true
        discountLabel.layer.cornerRadius = discountLabel.frame.height/2
    }
    override func prepareForReuse() {
        productImageView.image = nil
    }
    
    // MARK: - Setup Constraints
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
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
        ])
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.widthAnchor.constraint(equalToConstant: 30),
        ])
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(likeButton)
        NSLayoutConstraint.activate([
            likeButton.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            likeButton.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -5),
            likeButton.heightAnchor.constraint(equalToConstant: 28),
            likeButton.widthAnchor.constraint(equalToConstant: 28),
        ])
        
        discountLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(discountLabel)
        NSLayoutConstraint.activate([
            discountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            discountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
