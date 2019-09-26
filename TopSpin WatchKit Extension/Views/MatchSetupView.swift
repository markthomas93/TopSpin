//
//  MatchSetupView.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/31/19.
//

import Foundation
import SwiftUI

struct MatchSettingsView: View {
    @Binding var showMatchSetup: Bool
    @ObservedObject var dataManager = MatchSettingsDataManager()
    
    var body: some View {
        let setup = MatchSetupView(matchSettings: $dataManager.settings,
                       isLoading: $dataManager.loading,
                       saveSettings: dataManager.setMatchSettings)
        
        dataManager.onComplete = {
            self.showMatchSetup = false
        }
        
        return setup
    }
}

struct MatchSetupView: View {
    
    // MARK: - Binding
    
    @Binding var matchSettings: MatchSetting
    @Binding var isLoading: Bool

    let saveSettings: () -> Void
    
    // MARK: - State
    
    var body: some View {
        LoadingView(isShowing: $isLoading) {
            ScrollView {
                self.setupView()
            }
        }
        .navigationBarTitle(Text(Constants.Strings.MatchSetup.matchSetupTitle))
    }
    
    // MARK: - Private Methods
    
    private func setupView() -> some View {
        return VStack {
            Text(Constants.Strings.MatchSetup.scoreLimit)
            .font(.system(.headline, design: .rounded))
            
            HStack {
                ServeIntervalButton(scoreValue: 7, scoreLimit: $matchSettings.limit)
                ServeIntervalButton(scoreValue: 11, scoreLimit: $matchSettings.limit)
                ServeIntervalButton(scoreValue: 21, scoreLimit: $matchSettings.limit)
            }
            
            HStack {
                Text("\(Constants.Strings.MatchSetup.serveInterval):")
                .font(.footnote)
                Text("\(matchSettings.serveInterval)")
                .font(.footnote)
                .bold()
            }
            
            Toggle(Constants.Strings.MatchSetup.winByTwo, isOn: $matchSettings.winByTwo)
            .padding()
            
            Toggle(Constants.Strings.MatchSetup.workout, isOn: $matchSettings.startWorkout)
            .padding()
            
            Button(action: saveSettings) {
                HStack {
                    Text(Constants.Strings.MatchSetup.save)
                    .font(.system(.headline, design: .rounded))
                }
            }
            .accentColor(.green)
            .padding(.top, 10)
        }
    }
}

struct ServeIntervalButton: View {
    
    let scoreValue: Int

    @Binding var scoreLimit: Int
    
    var body: some View {
        Button(action: {
            self.scoreLimit = self.scoreValue
        }) {
            Text("\(scoreValue)")
        }
        .accentColor(scoreLimit == scoreValue ? .blue : nil)
        .font(.system(.body, design: .rounded))
    }
}

#if DEBUG
struct MatchSetupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MatchSettingsView(showMatchSetup: .constant(true))
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 4 - 44mm"))
                .environment(\.locale, Locale(identifier: "zh-Hans"))

            MatchSettingsView(showMatchSetup: .constant(true))
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 4 - 40mm"))
                .environment(\.locale, Locale(identifier: "zh-Hans"))
        }
    }
}
#endif
