//
//  SaveMatchDataManager.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/20/19.
//

import Foundation

class SaveMatchDataManager: ObservableObject {
         
    func save(_ match: Match) {
        var savedMatches = UserDefaultsManager.matchHistory
        savedMatches.append(match)
        
        UserDefaultsManager.matchHistory = savedMatches
        print("SaveMatchDataManager: - \(match.id ?? "0") saved")
    }
}
