//
//  MatchSetting.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/31/19.
//

import Foundation

struct MatchSetting: Codable, Equatable {
    let limit: Int
    let winByTwo: Bool
    let numberOfPlayers: Int
    let serveInterval: Int
}
