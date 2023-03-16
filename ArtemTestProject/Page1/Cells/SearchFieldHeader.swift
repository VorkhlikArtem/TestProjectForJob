//
//  SearchFieldHeader.swift
//  ArtemTestProject
//
//  Created by Артём on 15.03.2023.
//

import UIKit

class SearchFieldHeader: UICollectionReusableView {
    static let reuseId = "SearchFieldHeader"
    
    let searchField = SearchTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    func configure(title: String, buttonText: String) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        searchField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchField)
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            searchField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            searchField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            searchField.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}
