//
//  Models.swift
//  ArtemTestProject
//
//  Created by Артём on 14.03.2023.
//

import Foundation

struct LatestResponse: Decodable {
    let latest: [LatestItem]
}

struct FlashSaleResponse: Decodable {
    let flashSale: [FlashSaleItem]
}

struct LatestItem: Decodable {
    var category: String
    var name: String
    var price: Double
    var imageUrl: String
}

struct FlashSaleItem: Decodable {
    var category: String
    var name: String
    var price: Double
    var discount: Int
    var imageUrl: String
}

extension LatestItem {
    var formattedPrice: String {
        price.formattedPriceWithSeparatorAndTwoFractionDigits
    }
}
extension FlashSaleItem {
    var formattedPrice: String {
        price.formattedPriceWithSeparatorAndTwoFractionDigits
    }
}


