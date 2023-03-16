//
//  CellProtocol.swift
//  ArtemTestProject
//
//  Created by Артём on 15.03.2023.
//

import Foundation

protocol CellItem {
    var category: String { get  }
    var name: String { get  }
    var price: Int { get  }
    var imageUrl: String { get  }
}
extension CellItem {
    var formattedPrice: String {
        price.formattedPriceWithSeparatorAndTwoFractionDigits
    }
}
