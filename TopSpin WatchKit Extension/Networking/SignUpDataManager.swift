//
//  SignUpDataManager.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/29/19.
//

import Foundation
import RocketWatch

class SignUpDataManager: ObservableObject {
    
    @Published var loading: Bool = false
    @Published var didError: Bool = false
    
    @Published var user: UserSignUp? = nil {
        didSet {
            submit()
        }
    }
    
    var errorMessage: String?
    var onDidSignUp: (() -> Void)?
    
    func submit() {
        
        guard let user = user else { return }
        
        loading = true
        NetworkManager.sharedInstance.request(for: .signIn(user: user), UserTokenResponse.self) { [weak self] (result) in
            DispatchQueue.main.async {
                self?.loading = false
                self?.handleSignUp(result)
            }
        }
    }
    
    private func handleSignUp(_ result: Result<UserTokenResponse, APIError>) {
        switch result {
        case .success(let response):
            UserDefaultsManager.userToken = response.token
            UserDefaultsManager.loggedInUser = response.user
            onDidSignUp?()
            
        case .failure:
            didError = true
            errorMessage = "Sorry, there was an error. Please try again."
        }
    }
}
