//
//  LikeAndShareBlock.swift
//  ArtemTestProject
//
//  Created by Артём on 17.03.2023.
//

import UIKit

class LikeShareStack: UIStackView {
    
    let likeButton: UIButton = {
        let button = UIButton.init(type: .system)
        var config = UIButton.Configuration.plain()
        
        config.baseForegroundColor = #colorLiteral(red: 0.3298887014, green: 0.3344107866, blue: 0.5370991826, alpha: 1)
        config.contentInsets = .init(top: 10, leading: 8, bottom: 8, trailing: 8)
        config.image = UIImage(named: "heart")
        button.configuration = config
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton.init(type: .system)
        var config = UIButton.Configuration.plain()
        
        config.baseForegroundColor = #colorLiteral(red: 0.3298887014, green: 0.3344107866, blue: 0.5370991826, alpha: 1)
        config.contentInsets = .init(top: 8, leading: 8, bottom: 10, trailing: 8)
        config.image = UIImage(named: "share")
        button.configuration = config
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        distribution = .fillProportionally
        spacing = 5
        clipsToBounds = true
        layer.cornerRadius = 10
        backgroundColor = #colorLiteral(red: 0.8972175121, green: 0.9143759608, blue: 0.9387496114, alpha: 1)
        
        addArrangedSubview(likeButton)
        let separator = UIImageView(image: UIImage(named: "minus"))
        separator.tintColor = #colorLiteral(red: 0.3298887014, green: 0.3344107866, blue: 0.5370991826, alpha: 1)
        addArrangedSubview(separator)
        addArrangedSubview(shareButton)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
