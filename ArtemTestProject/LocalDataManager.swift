//
//  LocalFetcher.swift
//  ArtemTestProject
//
//  Created by Артём on 22.03.2023.
//

import Foundation
import Combine

struct LocalKeys {
    static let currentUser = "currentUser"
}

extension UserDefaults {
    @objc dynamic var currentUserId: String? {
        get {
            string(forKey: LocalKeys.currentUser)
        }
        set {
            set(newValue, forKey: LocalKeys.currentUser)

            }
    }
}

class LocalDataManager {
    
    static let shared = LocalDataManager()
    
    let defaults = UserDefaults.standard
    
    
   // private lazy var currentUserSubject = CurrentValueSubject<String?, Never>(currentUser)
    var currentUserIdPublisher: AnyPublisher<String?, Never> {
        defaults.publisher(for: \.currentUserId).eraseToAnyPublisher()
    }
    
//    var currentUser: String? {
//        get {
//            defaults.string(forKey: LocalKeys.currentUser)
//        }
//        set {
//            defaults.set(newValue, forKey: LocalKeys.currentUser)
//
//            }
//    }
    
    var currentUser: User? {
        if let id = defaults.currentUserId, let data = defaults.data(forKey: id) {
            return try? JSONDecoder().decode(User.self, from: data)
        }
        return nil
    }
    
    func saveCurrentUser(_ user: User) {
        guard let data = try? JSONEncoder().encode(user) else {return }
        defaults.set(data, forKey: user.email)
    }

    
    
    // MARK: - Methods For Login
    func logInUserChecking(email: String) -> Bool {
        if let data = defaults.data(forKey: email) {
            let user = try? JSONDecoder().decode(User.self, from: data)
            defaults.currentUserId = user?.email
            return true
        }
        return false
    }
    
   
    // MARK: - Methods For Sign in
    func isEmailUnique(email: String) -> Bool {
        return defaults.value(forKey: email) == nil
    }
    
    func saveNewUser(user: User) -> Bool {
        guard let data = try? JSONEncoder().encode(user) else {return false}
        defaults.set(data, forKey: user.email)
        defaults.currentUserId  = user.email
        return true
    }
    
    // MARK: - Log Out
    func logoutCurrentUser() {
        defaults.currentUserId = nil
    }
    
    private init() {}
    
}
