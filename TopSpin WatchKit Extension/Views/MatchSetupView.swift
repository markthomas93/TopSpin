//
//  MatchSetupView.swift
//  TopSpin WatchKit Extension
//
//  Created by Will Brandin on 7/31/19.
//

import Foundation
import SwiftUI

struct MatchSetupView: View {
    
    @State var scoreLimit: Double = 11
    @State var winByTwo: Bool = true
    @State var numberOfPlayers: Int = 2
    @State var serveInterval: Int = 2
    
    var onComplete: ((MatchSetting) -> Void)?
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Score Limit: \(Int(scoreLimit))")
                .font(.system(.headline, design: .rounded))
                
                Slider(value: $scoreLimit, from: 2, through: 21, by: 1)
                .accentColor(.green)
                .digitalCrownRotation($scoreLimit, from: 0, through: 21)
                
                Toggle("Win by Two", isOn: $winByTwo)
                .padding()
                
                Text("Number of Players")
                .font(.system(.headline, design: .rounded))
                .padding(.top)
                
                HStack {
                    Button(action: {
                        self.numberOfPlayers = 2
                    }) {
                        Text("2")
                    }
                    .accentColor(numberOfPlayers == 2 ? .blue : nil)
                    .font(.system(.body, design: .rounded))
                    
                    Button(action: {
                        self.numberOfPlayers = 4
                    }) {
                        Text("4")
                    }
                    .accentColor(numberOfPlayers == 4 ? .blue : nil)
                    .font(.system(.body, design: .rounded))
                }
                
                Text("Serve Interval")
                .font(.system(.headline, design: .rounded))
                .padding(.top)
                
                HStack {
                    Button(action: {
                        self.serveInterval = 2
                    }) {
                        Text("2")
                    }
                    .accentColor(serveInterval == 2 ? .blue : nil)
                    .font(.system(.body, design: .rounded))
                    
                    Button(action: {
                        self.serveInterval = 5
                    }) {
                        Text("5")
                    }
                    .font(.system(.body, design: .rounded))
                    .accentColor(serveInterval == 5 ? .blue : nil)
                }
                
                Button(action: {
                    let settings = MatchSetting(limit: Int(self.scoreLimit),
                                                winByTwo: self.winByTwo,
                                                numberOfPlayers: self.numberOfPlayers,
                                                serveInterval: self.serveInterval)
                    self.onComplete?(settings)
                }) {
                    HStack {
                        Text("🏓 Start Game")
                        .font(.system(.headline, design: .rounded))
                    }
                }
                .accentColor(.green)
                .padding(.top, 20)
            }
        }
        .navigationBarTitle(Text("Match Setup"))
    }
}

#if DEBUG
struct MatchSetupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MatchSetupView()
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 4 - 44mm"))
            MatchSetupView()
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 4 - 40mm"))
            MatchSetupView()
                .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 3 - 38mm"))
        }
    }
}
#endif
