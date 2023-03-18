//
//  DetailInfoCell.swift
//  ArtemTestProject
//
//  Created by Артём on 16.03.2023.
//

import UIKit

class DetailInfoCell: UICollectionViewCell {
    
    static var reuseId: String = "DetailInfoCell"
    
    let nameLabel = UILabel(font: .montserratBold(20), textColor: #colorLiteral(red: 0.08607355505, green: 0.09469824284, blue: 0.1493803263, alpha: 1))
    let descriptionLabel = UILabel(font: .montserratRegular(12), textColor: #colorLiteral(red: 0.5019204021, green: 0.5019834638, blue: 0.501899004, alpha: 1))
    let ratingButton = UIButton(font: .montserratBold(10), textColor: #colorLiteral(red: 0.08607355505, green: 0.09469824284, blue: 0.1493803263, alpha: 1), image: "star", imageColor: #colorLiteral(red: 0.9657155871, green: 0.7530063987, blue: 0.2584358752, alpha: 1))
    let reviewsLabel = UILabel(font: .montserratRegular(10), textColor: #colorLiteral(red: 0.5019204021, green: 0.5019834638, blue: 0.501899004, alpha: 1))
    let colorLabel = UILabel(text: "Color:", font: .montserratMedium(15), textColor: #colorLiteral(red: 0.4509437084, green: 0.4510009885, blue: 0.4509242177, alpha: 1))
    var colorSegmentedControl: ColorSegmentedControl!
    
    let priceLabel = UILabel(font: .montserratBold(20), textColor: #colorLiteral(red: 0.08607355505, green: 0.09469824284, blue: 0.1493803263, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 15
        nameLabel.numberOfLines = 2
        descriptionLabel.numberOfLines = 0
    }
    
    override func prepareForReuse() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //clipsToBounds = false
        layer.masksToBounds = false
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 30
        
    }
    
    
    func configure(with detailInfo: DetailInfoModel) {
        nameLabel.text = detailInfo.name
        descriptionLabel.text = detailInfo.description
        ratingButton.setTitle(detailInfo.formattedRating, for: .normal)
        reviewsLabel.text = detailInfo.formattedReviews
        priceLabel.text = detailInfo.formattedPrice
        colorSegmentedControl = ColorSegmentedControl(productColors: detailInfo.colors)
        setupConstraints()
    }
    
    func setupConstraints() {
        let ratingReviewsStack = UIStackView(arrangedSubviews: [ratingButton, reviewsLabel])
        ratingReviewsStack.axis = .horizontal
        ratingReviewsStack.spacing = 5
        
        let vStack = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel, ratingReviewsStack, colorLabel, colorSegmentedControl])
        vStack.axis = .vertical
        vStack.alignment = .leading
        vStack.distribution = .equalSpacing
        vStack.spacing = 20
        
        let hStack = UIStackView(arrangedSubviews: [vStack, priceLabel])

        hStack.axis = .horizontal
        hStack.alignment = .top
        hStack.distribution = .equalSpacing
        hStack.spacing = 50
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(hStack)
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: topAnchor),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)

        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - SwiftUI
import SwiftUI
struct DetailProvider1: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = UINavigationController(rootViewController: DetailViewController())
        
   
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
    }
}