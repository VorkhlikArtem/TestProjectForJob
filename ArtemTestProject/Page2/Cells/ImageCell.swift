//
//  ImageCell.swift
//  ArtemTestProject
//
//  Created by Артём on 16.03.2023.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    static var reuseId: String = "ProductDetailCVCell"
    
    let productImageView = WebImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        layer.cornerRadius = 7
        productImageView.contentMode = .scaleAspectFill
        setupConstraints()
    }
    
    override func prepareForReuse() {
        productImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //clipsToBounds = false
        layer.masksToBounds = false
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 30
        
        productImageView.layer.cornerRadius = 7
    }
    
    
    func configure(with urlString: String) {
        productImageView.set(imageURL: urlString)
    }
    
    func setupConstraints() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(productImageView)
        productImageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor)

        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
