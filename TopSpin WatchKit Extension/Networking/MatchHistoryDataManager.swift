//
//  MatchHistoryDataManager.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/7/19.
//

import Foundation
import RocketWatch

class MatchHistoryWebService: ObservableObject {
    
    @Published var matches: [Match] = []
    @Published var isLoading: Bool = false
    @Published var didFail: Bool = false
    
    func fetch() {
        requestMatchHistory()
    }
    
    // 1. Fetch History from API
    private func requestMatchHistory() {
        guard let id = UserDefaultsManager.loggedInUser?.id else {
            handleHistory(.failure(.requestFailed))
            return
        }
        
        isLoading = true
        NetworkManager.sharedInstance.requestWithListResponse(for: .getMatches(id: id), [Match].self) { [weak self] (result) in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.handleHistory(result)
            }
        }
    }
    
    private func handleHistory(_ result: Result<[Match], APIError>) {
        switch result {
        case.success(let matches):
            compareSavedCache(to: matches)
            
        case .failure:
            didFail = true
        }
    }
    
    // 2. If any local id is not listed from API
    private func compareSavedCache(to cloudMatches: [Match]) {
        let differnece = UserDefaultsManager.matchHistory.difference(from: cloudMatches)
        if !differnece.isEmpty {
            uploadDifference(differnece) // 3. Perform a PUT with all matches not in cloud
        } else {
            matches = UserDefaultsManager.matchHistory
        }
    }
    
    private func uploadDifference(_ matches: [Match]) {
        guard let id = UserDefaultsManager.loggedInUser?.id else {
            handleUpload(.failure(.requestFailed))
            return
        }
        
        isLoading = true
        NetworkManager.sharedInstance.requestWithListResponse(for: .putMatches(id: id, matches: matches), [Match].self) { [weak self] (result) in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.handleUpload(result)
            }
        }
    }
    
    private func handleUpload(_ result: Result<[Match], APIError>) {
        switch result {
        case.success(let matches):
            // 4. Save API matches locally
            UserDefaultsManager.matchHistory = matches
            
            // 5. Set `matches` to notify the Observable.
            self.matches = matches
            
        case .failure:
            didFail = true
        }
    }
}
