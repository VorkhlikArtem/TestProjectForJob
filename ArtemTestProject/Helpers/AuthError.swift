//
//  AuthError.swift
//  ArtemTestProject
//
//  Created by Артём on 22.03.2023.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case userAlreadyExists
    case noSuchUser
    case unknownError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill all fields", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Invalid Email", comment: "")
        case .userAlreadyExists:
            return NSLocalizedString("This email has been already registered", comment: "")
        case .noSuchUser:
            return NSLocalizedString("The user has not been registered yet", comment: "")
        case .unknownError:
            return NSLocalizedString("Try again", comment: "")
        }
    }
}
