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
            Alert(title: Text("Uh oh! 😅"),
                  message: Text(dataManager.errorMessage ?? ""),
                  dismissButton: .cancel(Text("Okay")))
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
                WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(name: "MatchSetup", context: [] as AnyObject),
                                                                                   (name: "MatchHistory", context: [] as AnyObject)])
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