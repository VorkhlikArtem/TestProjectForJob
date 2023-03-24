//
//  AuthService.swift
//  ArtemTestProject
//
//  Created by Артём on 22.03.2023.
//

import Foundation
import Combine

class AuthService {
    let dataManager = LocalDataManager.shared
    
    func login(email: String?, password: String?) -> AnyPublisher<User?, Error> {
        
        return Future<User?, Error> { promise in
            
            guard Validator.areAllFilled(strings: [email, password]) else {
                return promise(.failure(AuthError.notFilled))
            }
            guard Validator.isValidEmail(email!) else {
                let suggestedEmail = Validator.suggestEmail(wrongEmail: email!)
                return promise(.failure(AuthError.invalidEmail(suggestedEmail: suggestedEmail) ))
            }
            guard self.dataManager.logInUserChecking(email: email!) else {
                return promise(.failure(AuthError.noSuchUser))
            }
            
            return promise(.success(self.dataManager.currentUser))
            
        }.eraseToAnyPublisher()
    }
    
    func signin(firstName: String?, lastName: String?, email: String?) -> AnyPublisher<User?, Error> {
        
        return Future<User?, Error> { promise in
            
            guard Validator.areAllFilled(strings: [firstName, lastName, email]) else {
                return promise(.failure(AuthError.notFilled))
            }
            guard Validator.isValidEmail(email!) else {
                let suggestedEmail = Validator.suggestEmail(wrongEmail: email!)
                return promise(.failure(AuthError.invalidEmail(suggestedEmail: suggestedEmail) ))
            }
            
            guard self.dataManager.isEmailUnique(email: email!) else {
                return promise(.failure(AuthError.userAlreadyExists))
            }
            
            let newUser = User(firstName: firstName!, lastName: lastName!, email: email!, avatar: nil, balance: 1500)
            guard self.dataManager.saveNewUser(user: newUser) else {
                return promise(.failure(AuthError.unknownError))
            }
            
            return promise(.success(self.dataManager.currentUser))
            
        }.eraseToAnyPublisher()
       
        
    }
}
