//
//  Category.swift
//  ArtemTestProject
//
//  Created by Артём on 15.03.2023.
//

import Foundation

struct CategoryItem {
    let title: String
    let imageName: String
}

extension CategoryItem {
    static let categorySectionModel: [CategoryItem] = [
        CategoryItem(title: "Phones", imageName: "Phones"),
        CategoryItem(title: "Headphones", imageName: "Hphones"),
        CategoryItem(title: "Games", imageName: "Games"),
        CategoryItem(title: "Cars", imageName: "Cars"),
        CategoryItem(title: "Furniture", imageName: "Furniture"),
        CategoryItem(title: "Kids", imageName: "Kids"),

    ]
}
