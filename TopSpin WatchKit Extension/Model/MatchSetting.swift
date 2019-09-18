//
//  MatchSetting.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/31/19.
//

import Foundation
import RallyWatch

struct MatchSetting: Codable, Equatable, RallyMatchConfigurable {
    let limit: Int
    let winByTwo: Bool
    let numberOfPlayers: Int
    let serveInterval: Int
    let startWorkout: Bool
}
