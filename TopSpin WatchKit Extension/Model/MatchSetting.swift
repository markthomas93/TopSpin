//
//  MatchSetting.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/31/19.
//

import Foundation
import RallyWatch

struct MatchSetting: Codable, Equatable, RallyMatchConfigurable {
    let id: String?
    var limit: Int
    var winByTwo: Bool
    var startWorkout: Bool
    
    var serveInterval: Int {
        limit == 21 ? 5 : 2
    }
    
    private enum CodingKeys : String, CodingKey {
        case id = "_id"
        case limit, winByTwo, startWorkout
    }
}

extension MatchSetting {
    static let defaultSettings = MatchSetting(id: nil, limit: 11, winByTwo: true, startWorkout: true)
}
