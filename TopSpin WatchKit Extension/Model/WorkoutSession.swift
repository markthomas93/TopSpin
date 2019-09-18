//
//  WorkoutSession.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/25/19.
//

import Foundation

struct WorkoutSession: Codable, Equatable, Hashable {
    let id: String?
    let maxHeartRate: Double
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case maxHeartRate
    }
    
    init(maxHeartRate: Double) {
        self.id = nil
        self.maxHeartRate = maxHeartRate
    }
}
