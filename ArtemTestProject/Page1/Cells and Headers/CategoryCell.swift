//
//  LatestCell.swift
//  ArtemTestProject
//
//  Created by Артём on 14.03.2023.
//

import UIKit

class SelectCategoryCell: UICollectionViewCell {
    
    static var reuseId: String = "SelectCategoryCell"
    
    let categoryImageView = UIImageView()
    let categoryTitle: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(10)
        label.textColor = #colorLiteral(red: 0.6514083147, green: 0.6558839083, blue: 0.6730117202, alpha: 1)
        
        return label
    }()
    let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9337416887, green: 0.9382420778, blue: 0.9553256631, alpha: 1)
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        categoryImageView.contentMode = .scaleAspectFit
        self.backgroundColor = .clear
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleView.layer.cornerRadius = circleView.frame.height / 2
    }
    
    func configure(with categoryModel: CategoryItem) {
        categoryImageView.image = UIImage(named: categoryModel.imageName)?.withTintColor(.gray)
        categoryTitle.text = categoryModel.title
    }
    
    // MARK: - Setup Constraints
    func setupConstraints() {
        circleView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(circleView)
        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleView.heightAnchor.constraint(equalToConstant: 60),
            circleView.widthAnchor.constraint(equalToConstant: 60),

        ])
        
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        circleView.addSubview(categoryImageView)
        NSLayoutConstraint.activate([
            categoryImageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            categoryImageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            categoryImageView.heightAnchor.constraint(equalToConstant: 35),
            categoryImageView.widthAnchor.constraint(equalToConstant: 35),

        ])
        
        categoryTitle.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(categoryTitle)
        NSLayoutConstraint.activate([
            categoryTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryTitle.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 7)

        ])
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
