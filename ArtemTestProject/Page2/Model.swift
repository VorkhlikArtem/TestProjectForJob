//
//  Model.swift
//  ArtemTestProject
//
//  Created by Артём on 16.03.2023.
//

import Foundation

struct DetailModel: Decodable {
    let name: String
    let description: String
    let rating: Double
    let numberOfReviews: Int
    let price: Double
    let colors: [String]
    let imageUrls: [String]
    
}

struct ImageModel: Hashable {
    let url: String
    let id: Int
}

struct DetailInfoModel: Hashable {
    let name: String
    let description: String
    let rating: Double
    let numberOfReviews: Int
    let price: Double
    let colors: [String]
    
    init(from detailModel: DetailModel) {
        self.name = detailModel.name
        self.description = detailModel.description
        self.rating = detailModel.rating
        self.numberOfReviews = detailModel.numberOfReviews
        self.price = detailModel.price
        self.colors = detailModel.colors
        
    }
}

extension DetailInfoModel {
    var formattedRating: String  { String( round(rating*10) / 10) }
    var formattedReviews: String { "(\(numberOfReviews) reviews)" }
    var formattedPrice: String { price.formattedPriceWithSeparatorAndTwoFractionDigits  }
}

//{
//  "name": "Reebok Classic",
//  "description": "Shoes inspired by 80s running shoes are still relevant today",
//  "rating": 4.3,
//  "number_of_reviews": 4000,
//  "price": 24,
//  "colors": [
//    "#ffffff",
//    "#b5b5b5",
//    "#000000"
//  ],
//  "image_urls": [
//  
//  ]
//}
