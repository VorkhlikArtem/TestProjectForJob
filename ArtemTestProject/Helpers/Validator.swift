//
//  Validator.swift
//  ArtemTestProject
//
//  Created by Артём on 22.03.2023.
//

import Foundation

class Validator {
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func areAllFilled(strings: [String?]) -> Bool {
        return strings.allSatisfy{ !($0 ?? "").isEmpty }
    }
    
}
