//
//  Game.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/26/19.
//

import SwiftUI

/// A single game that is played. A series of games will be a match.
/// A game can only have two teams.
/// A Team can have multiple players or just one. 
struct Match: Codable, Identifiable {
    let id: Int
    let settings: MatchSetting
    let teamOne: Team
    let teamTwo: Team
    let score: Score
}

/// A team refers to the player or group of players in a game.
struct Team: Codable, Equatable {
    let players: [Player]
    
    var teamPlayers: [String] {
        return players.map { $0.name }
    }
}

struct Score: Codable, Equatable {
    let teamOneScore: Int
    let teamTwoScore: Int
    let teamOne: Team
    let teamTwo: Team
    
    var winner: Team {
        return teamOneScore > teamTwoScore ? teamOne : teamTwo
    }
}
