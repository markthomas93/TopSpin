//
//  Game.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/26/19.
//

import SwiftUI
import RocketWatch

/// A single game that is played. A series of games will be a match.
/// A game can only have two teams.
/// A Team can have multiple players or just one. 
struct Match: Codable, Identifiable, Equatable, Hashable {
    let id: String?
    let score: Score
    let date: String
    let workout: WorkoutSession?
    
    private enum CodingKeys : String, CodingKey {
        case id = "_id"
        case score, date, workout
    }
    
    init(score: Score, workout: WorkoutSession?) {
        self.id = nil
        self.score = score
        self.date = Date().string(with: .serverDateFormatISO)
        self.workout = workout
    }
    
    var formattedDate: String? {
        return Date(iso8601String: date)?.string(with: .shortMonthDay)
    }
}

// Player will always be user
struct Score: Codable, Equatable, Hashable {
    let playerScore: Int
    let opponentScore: Int
}
