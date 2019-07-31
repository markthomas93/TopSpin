//
//  Player.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/26/19.
//

import Foundation

/// A player is someone who is represented in the game.
/// The user will have their user name.
/// Default to Player Two, Player 3, etc.
/// Will be able to change the name, via dictation, sribble, or Pass through keyboard. 
struct Player: Codable, Equatable {
    let name: String
}
