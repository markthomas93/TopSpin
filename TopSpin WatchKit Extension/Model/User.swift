//
//  User.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/29/19.
//

import Foundation
import RocketWatch

struct User: Codable, Identifiable {
    let id: String
    let name: String
    let email: String
    let userCredential: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email, userCredential, name
    }
}

struct UserSignUp: Codable {
    let name: String?
    let email: String?
    let userCredential: String
}

struct UserTokenResponse: Codable {
    let user: User
    let token: String
}
