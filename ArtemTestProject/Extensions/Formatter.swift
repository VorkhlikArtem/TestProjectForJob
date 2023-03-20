//
//  Formatter.swift
//  ArtemTestProject
//
//  Created by Артём on 15.03.2023.
//

import Foundation

extension Numeric {
    var formattedPriceWithSeparatorAndTwoFractionDigits: String {

        let formatter = NumberFormatter()
//        formatter.currencyCode = "USD"
//        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return "$ " + (formatter.string(for: self) ?? "")
    }
    
    var formattedWithCommaDecimalSeparator2: String {
        let formatter = NumberFormatter()
     //   formatter.currencyCode = "USD"
       // formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","

        return "$ " + (formatter.string(for: self) ?? "")
    }
    
    var formattedWithCommaDecimalSeparator3: String {
        let formatter = NumberFormatter()
     //   formatter.currencyCode = "USD"
       // formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 3
        formatter.maximumFractionDigits = 3
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","

        return "$ " + (formatter.string(for: self) ?? "")
    }
}
