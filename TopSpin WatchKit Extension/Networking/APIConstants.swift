//
//  APIConstants.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/29/19.
//

import Foundation

struct APIConstants {
    
    struct EndPoint {
        static let production = "https://top-spin-production.herokuapp.com/api"
        static let staging = "https://top-spin-staging.herokuapp.com/api"
        static let local = "http://localhost:5000/api"
    }
    
    struct User {
        static let users = "users"
    }
    
    struct Match {
        static let matches = "matches"
        
        static func userMatches(_ id: String) -> String {
            return "\(APIConstants.User.users)/\(id)/\(APIConstants.Match.matches)"
        }
    }
}
