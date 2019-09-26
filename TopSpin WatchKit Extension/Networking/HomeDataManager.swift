//
//  HomeDataManager.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 9/25/19.
//

import Foundation
import RocketWatch

class HomeDataManager: ObservableObject {
    
    @Published var loading: Bool = false
    @Published var didError: Bool = false
    
    var onComplete: (() -> Void)?
    var errorMessage: String?

    func getMatchSettings() {
        loading = true
        NetworkManager.sharedInstance.request(for: .getMatchSettings, MatchSetting.self) { [weak self] result in
            
            DispatchQueue.main.async {
                self?.loading = false
                self?.handleSettings(result)
            }
        }
    }
    
    private func handleSettings(_ result: Result<MatchSetting, APIError>) {
        switch result {
        case .success(let settings):
            UserDefaultsManager.matchSettings = settings
            
        case .failure:
            didError = true
            errorMessage = "Sorry, there was an error. Please try again."
        }
    }
}
