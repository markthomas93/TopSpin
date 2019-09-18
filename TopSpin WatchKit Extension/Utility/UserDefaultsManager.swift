//
//  UserDefaultsManager.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/20/19.
//

import Foundation

class UserDefaultsManager {
     
    private static let userTokenKey = "userTokenKey"
    private static let gameHistoryKey = "gameHistoryKey"
    private static let loggedInUserKey = "loggedInUserKey"
    
    static var userToken: String? {
        get {
            UserDefaults.standard.string(forKey: userTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: userTokenKey)
        }
    }
    
    static var loggedInUser: User? {
        get {
            let decoder = JSONDecoder()

            if let userData = UserDefaults.standard.object(forKey: loggedInUserKey) as? Data,
                let user = try? decoder.decode(User.self, from: userData) {
                    return user
            } else {
                return nil
            }
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: loggedInUserKey)
            }
        }
    }
    
    static var matchHistory: [Match] {
        get {
            let decoder = JSONDecoder()

            if let matchHistoryData = UserDefaults.standard.object(forKey: gameHistoryKey) as? Data,
                let matchHistory = try? decoder.decode([Match].self, from: matchHistoryData) {
                    return matchHistory
            } else {
                return []
            }
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: gameHistoryKey)
            }
        }
    }
    
    // MARK: - Methods
    
    static func clear() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
}
