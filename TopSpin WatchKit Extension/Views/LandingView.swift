//
//  LandingView.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 8/29/19.
//

import SwiftUI

struct LandingView: View {
    
    @ObservedObject private var dataManager = SignUpDataManager()
    
    var body: some View {
        LoadingView(isShowing: $dataManager.loading) {
            self.mainView
        }.alert(isPresented: $dataManager.didError) {
            Alert(title: Text(Constants.Strings.General.uhOhEmoji),
                  message: Text(dataManager.errorMessage ?? ""),
                  dismissButton: .cancel(Text(Constants.Strings.General.okay)))
        }
    }
    
    private var mainView: some View {
        VStack {
            Text("Top Spin")
            Spacer()
            
            OnBoardingView()
            
            SignInWithAppleButton(user: $dataManager.user)
        }
    }
    
    init() {
        subscribeToDataManager()
    }
    
    private func subscribeToDataManager() {
        dataManager.onDidSignUp = {
            DispatchQueue.main.async {
                let viewNames = ["Settings", "Home", "MatchHistory"]
                WKInterfaceController.reloadRootPageControllers(withNames: viewNames, contexts: nil, orientation: .horizontal, pageIndex: 1)
            }
        }
    }
}

struct OnBoardingView: View {
    var body: some View {
        VStack {
            Text("🏓")
            .font(.title)
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LandingView()
        }
    }
}
