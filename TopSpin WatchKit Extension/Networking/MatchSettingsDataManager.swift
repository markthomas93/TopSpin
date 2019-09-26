//
//  MatchSettingsDataManager.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 9/25/19.
//

import Foundation
import RocketWatch

class MatchSettingsDataManager: ObservableObject {
    
    @Published var loading: Bool = false
    @Published var didError: Bool = false
    @Published var settings: MatchSetting = UserDefaultsManager.matchSettings
    
    var onComplete: (() -> Void)?
    var errorMessage: String?

    func setMatchSettings() {
        
        guard let settings = settings else {
            return
        }
        
        self.loading = true
        NetworkManager.sharedInstance.request(for: .updateSettings(settings: settings), MatchSetting.self) { [weak self] (result) in
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
            onComplete?()

        case .failure:
            didError = true
            errorMessage = "Sorry, there was an error. Please try again."
        }
    }}
