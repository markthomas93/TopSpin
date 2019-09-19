//
//  MatchSetupView.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/31/19.
//

import Foundation
import SwiftUI

struct MatchSetupView: View {
    
    @State private var scoreLimit: Double = 11
    @State private var winByTwo: Bool = true
    @State private var startWorkout: Bool = true
    @State private var numberOfPlayers: Int = 2
    @State private var serveInterval: Int = 2
    
    var onComplete: ((MatchSetting) -> Void)?
    
    var body: some View {
        ScrollView {
            VStack {
                Text("\(Constants.Strings.MatchSetup.scoreLimit) \(Int(scoreLimit))")
                .font(.system(.headline, design: .rounded))
                
                Slider(value: $scoreLimit, in: ClosedRange(uncheckedBounds: (lower: 0, upper: 21)), step: 1)
                .accentColor(.green)
                .digitalCrownRotation($scoreLimit, from: 0, through: 21)
                
                Toggle(Constants.Strings.MatchSetup.winByTwo, isOn: $winByTwo)
                .padding()
                
                Text(Constants.Strings.MatchSetup.numberOfPlayers)
                .font(.system(.headline, design: .rounded))
                .padding(.top)
                
                HStack {
                    Button(action: {
                        self.numberOfPlayers = 2
                    }) {
                        Text(Constants.Strings.MatchSetup.numberTwo)
                    }
                    .accentColor(numberOfPlayers == 2 ? .blue : nil)
                    .font(.system(.body, design: .rounded))
                    
                    Button(action: {
                        self.numberOfPlayers = 4
                    }) {
                        Text(Constants.Strings.MatchSetup.numberFour)
                    }
                    .accentColor(numberOfPlayers == 4 ? .blue : nil)
                    .font(.system(.body, design: .rounded))
                }
                
                Text(Constants.Strings.MatchSetup.serveInterval)
                .font(.system(.headline, design: .rounded))
                .padding(.top)
                
                HStack {
                    Button(action: {
                        self.serveInterval = 2
                    }) {
                        Text(Constants.Strings.MatchSetup.numberTwo)
                    }
                    .accentColor(serveInterval == 2 ? .blue : nil)
                    .font(.system(.body, design: .rounded))
                    
                    Button(action: {
                        self.serveInterval = 5
                    }) {
                        Text(Constants.Strings.MatchSetup.numberFive)
                    }
                    .font(.system(.body, design: .rounded))
                    .accentColor(serveInterval == 5 ? .blue : nil)
                }
                
                Toggle(Constants.Strings.MatchSetup.workout, isOn: $startWorkout)
                .padding()
                
                Button(action: complete) {
                    HStack {
                        Text(Constants.Strings.MatchSetup.startGame)
                        .font(.system(.headline, design: .rounded))
                    }
                }
                .accentColor(.green)
                .padding(.top, 10)
                
                Button(action: logout) {
                    HStack {
                        Text(Constants.Strings.MatchSetup.logOut)
                    }
                }
                .padding(.top, 20)
            }
        }
        .navigationBarTitle(Text(Constants.Strings.MatchSetup.matchSetupTitle))
    }
    
    private func complete() {
        let settings = MatchSetting(limit: Int(scoreLimit),
                                    winByTwo: winByTwo,
                                    numberOfPlayers: numberOfPlayers,
                                    serveInterval: serveInterval,
                                    startWorkout: startWorkout)
        onComplete?(settings)
    }
    
    private func logout() {
        UserDefaultsManager.clear()
        WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(name: "LandingView", context: [] as AnyObject)])
    }
}

#if DEBUG
struct MatchSetupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MatchSetupView()
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 4 - 44mm"))
                .environment(\.locale, Locale(identifier: "zh-Hans"))

            MatchSetupView()
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 4 - 40mm"))
                .environment(\.locale, Locale(identifier: "zh-Hans"))
        }
    }
}
#endif
